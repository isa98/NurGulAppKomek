import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> _initAppInitials() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await ScreenUtil.ensureScreenSize();

  await initLoginStatus();
}

Future<void> _initFBInitials() async {
  try {
    await initFCMFunctions();
  } catch (e) {
    debugPrint('FCM error: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _initAppInitials();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  final bool isDarkMode = prefs.getBool(Constants.isDarkMode) ?? false;
  final ThemeMode themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  final String locale = await getLocale();

  // FlutterNativeSplash.remove();

  // FB functions needs to init after
  /// [FlutterNativeSplash.remove()]
  await _initFBInitials();

  runApp(AppRoot(isTurkmen: locale == 'tm', themeMode: themeMode));
}

class AppRoot extends StatelessWidget {
  final bool isTurkmen;
  final ThemeMode themeMode;
  const AppRoot({
    Key? key,
    required this.isTurkmen,
    required this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NurgulApp(isTurkmen: isTurkmen, themeMode: themeMode),
    );
  }
}

class NurgulApp extends StatelessWidget {
  final bool isTurkmen;
  final ThemeMode themeMode;
  const NurgulApp(
      {super.key, required this.isTurkmen, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ScreenUtilInit(
          designSize: Size(constraints.maxWidth, constraints.maxHeight),
          builder: (_, child) => GetMaterialApp(
            initialRoute: AppRoutes.splash,
            getPages: AppPages.list,
            debugShowCheckedModeBanner: false,
            locale:
                isTurkmen ? const Locale('tm', 'TM') : const Locale('ru', 'RU'),
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: LocalizationService(),
            localizationsDelegates: const [
              BackButtonTextDelegate(),
            ],
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
          ),
        );
      },
    );
  }
}

// NOTE flowerstorenurgul@gmail.com, qazwsx3@1
// TODO:
// Similar product text
// add remove button shadow remove
// Notification navigation
// Add Notification ios
// Notification icon xml