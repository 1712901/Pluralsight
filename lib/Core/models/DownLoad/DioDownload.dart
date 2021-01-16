import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class DioDownload{

  final Dio _dio = Dio();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  DioDownload(FlutterLocalNotificationsPlugin localNotificationsPlugin){
    flutterLocalNotificationsPlugin=localNotificationsPlugin;
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    var permission =await Permission.storage.status;
    if(!(permission.isGranted)){
      await Permission.storage.request();
      permission=await Permission.storage.status;
    }
    return permission==PermissionStatus.granted;
  }

  Future<void> download(String path,String fileUrl,Function(int received,int total) onReceiveProgress) async {
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      await _startDownload(path,fileUrl,onReceiveProgress);
    } else {
      // handle the scenario when user declines the permissions
    }
  }
  Future<void> _startDownload(String savePath,String fileUrl,Function(int received,int total) onReceiveProgress) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(
          fileUrl,
          savePath,
          onReceiveProgress: onReceiveProgress
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result);
    }
  }
  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        priority: Priority.high,
        importance: Importance.max
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android:android,iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess ? 'File has been downloaded successfully!' : 'There was an error while downloading the file.',
        platform,
        payload: json
    );
  }
  Future<String> createPath({String url,String nameVideo,String courseID}) async {
    if(url==null ) return null;
    var dir = await getApplicationDocumentsDirectory();
    String name=url.split(new RegExp(r"(\/|\?)")).firstWhere((element) => element.endsWith(".mp4"),orElse: ()=>null);
    if(name==null)
      return null;
    return "${dir.path}/$courseID-$nameVideo.mp4";
  }
}