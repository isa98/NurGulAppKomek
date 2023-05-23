import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../firebase_options.dart';
import '../../app.dart';
import 'download_file.dart';

class FCMFunctions {
  static final FCMFunctions _singleton = FCMFunctions._internal();

  FCMFunctions._internal();

  factory FCMFunctions() {
    return _singleton;
  }

  late FirebaseMessaging messaging;

  late FlutterLocalNotificationsPlugin flip;

  late InitializationSettings initSettings;
//************************************************************************************************************ */
  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//************************************************************************************************************ */

  Future initApp() async {
    debugPrint('init firebase');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    messaging = FirebaseMessaging.instance;

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      //for IOS Foreground Notification
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      flip = FlutterLocalNotificationsPlugin();
      var initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/ic_launcher');
      var initializationSettingsIOs = const DarwinInitializationSettings();
      initSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    }
  }

  Future subscribeToTopics(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  ///Expire : https://firebase.google.com/docs/cloud-messaging/manage-tokens
  Future<String?> getFCMToken() async {
    final fcmToken = await messaging.getToken();
    debugPrint('Get FCM Token ------->: $fcmToken');
    return fcmToken;
  }

  void tokenListener() {
    debugPrint('tokenListener');
    messaging.onTokenRefresh.listen((fcmToken) {
      debugPrint('Listen FCM Token ------->: $fcmToken');
      // If necessary send token to application server.
    }).onError((err) {
      debugPrint('tokenListener err $err');
    });
  }

  /// IOS
  Future iosWebPermission() async {
    if (Platform.isIOS || kIsWeb) {
      /* NotificationSettings settings = */ await messaging.requestPermission();
    }
  }

  ///Foreground messages
  ///
  ///To handle messages while your application is in the foreground, listen to the onMessage stream.
  void foreGroundMessageListener() {
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  // foreground
  Future<void> _onMessageHandler(RemoteMessage message) async {
    debugPrint('onMessageHandler');
    _showNotificationViaFBConsole(message);
  }

  // FLUTTER_NOTIFICATION_CLICK

  // background (app minimized)
  Future<void> _onMessageOpenedApp(RemoteMessage message) async => _performClickAction(message);

  Future<void> _showNotification(RemoteMessage message) async {
    final String imgUrl = message.data['imageUrl'] ?? '';
    debugPrint('imgUrl $imgUrl');
    final RemoteNotification? notification = message.notification;

    final largeIconPath = await downloadFile(imgUrl, 'largeIcon');
    final bigPicturePath = await downloadFile(imgUrl, 'bigPicture');

    final BigPictureStyleInformation styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id,
      channel.name,
      icon: '@drawable/ic_launcher',
      channelDescription: channel.description,
      // importance: Importance.max,
      // priority: Priority.high,
      color: ThemeColor.mainColor,
      styleInformation: styleInformation,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
    await flip.show(0, notification?.title, notification?.body, platformChannelSpecifics, payload: 'Default_Sound');
  }

  Future<void> _showNotificationViaFBConsole(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    if (notification == null) return;

    final String? imgUrl = _getImageUrl(notification);

    debugPrint('==> imgUrl: $imgUrl ');

    BigPictureStyleInformation? styleInformation;
    if (imgUrl != null) {
      final largeIconPath = await downloadFile(imgUrl, 'largeIcon');
      final bigPicturePath = await downloadFile(imgUrl, 'bigPicture');

      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        largeIcon: FilePathAndroidBitmap(largeIconPath),
      );
    }

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id,
      channel.name,
      icon: '@drawable/ic_launcher',
      channelDescription: channel.description,
      // importance: Importance.max,
      priority: Priority.high,
      // color: ThemeColor.mainColor,
      styleInformation: styleInformation,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flip.initialize(
      initSettings,
      // onDidReceiveBackgroundNotificationResponse: (details) {
      //   debugPrint('==> ${details.payload}');
      // },
      onDidReceiveNotificationResponse: (details) {
        debugPrint('onDidReceiveNotificationResponse');
        // _performClickAction(message);
      },
    );
    await flip.show(0, notification.title, notification.body, platformChannelSpecifics, payload: 'Default_Sound');
  }

  Future<void> _performClickAction(RemoteMessage message) async {
    // if (message.data['type'] == 'product') {
    // final int productId = int.parse(message.data['id']);
    // final ProductModel? model = await ProductApi.getProductById(productId);
    // if (model != null) Get.to(() => ProductDetailsPage(model: model));
    // } else if (message.data['type'] == 'filter') {
    // message.data.remove('type');
    // navigateToProductListScreen(message.data, false);
    // } else {
    // open dialog
    // if (message.notification == null) return;

    // Get.to(
    //   () => NotificationPage(title: message.notification!.title ?? '', data: message.notification!.body ?? ''),
    // );
    // }
  }

  String? _getImageUrl(RemoteNotification notification) {
    if (Platform.isIOS && notification.apple != null) return notification.apple?.imageUrl;
    if (Platform.isAndroid && notification.android != null) return notification.android?.imageUrl;
    return null;
  }
}

final fcmFunctions = FCMFunctions();

// backgroundHandler must be on top and separated
Future<void> onBackgroundHandler(RemoteMessage message) async {
  // fcmFunctions._showNotification(message);
  fcmFunctions._showNotificationViaFBConsole(message);
}

Future<void> initFCMFunctions() async {
  await fcmFunctions.initApp();
  await fcmFunctions.iosWebPermission();

  FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);

  await fcmFunctions.getFCMToken();
  fcmFunctions.tokenListener();
  fcmFunctions.foreGroundMessageListener();
  await fcmFunctions.subscribeToTopics('notifications');
}

/* final http.Response response = await http.get(Uri.parse(URL));
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(base64Encode(image)),
      largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Encode(image)),
    );
    flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000),
      title,
      description,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            styleInformation: bigPictureStyleInformation),
      ),
    ); */
