import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<String> downloadFile(String url, String filename) async {
  var dio = Dio();
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$filename';
  // final response = await
  Response response = await dio.get(url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: const Duration(seconds: 5000000),
      ));

  final file = File(filePath);

  var raf = file.openSync(mode: FileMode.write);
  // response.data is List<int> type
  raf.writeFromSync(response.data);
  await raf.close();
 
  return filePath;
}
