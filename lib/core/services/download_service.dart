import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:provider/provider.dart';

class DownloadService {
  static final DownloadService _instance = DownloadService._internal();
  factory DownloadService() => _instance;

  DownloadService._internal();

  final ReceivePort _port = ReceivePort();
  bool _isInitialized = false;

  void initialize(BuildContext context) {
    if (!_isInitialized) {
      _isInitialized = true;
      IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        _handleDownloadProgress(context, data);
      });
      FlutterDownloader.registerCallback(downloadCallback);
    }
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void _handleDownloadProgress(BuildContext context, List<dynamic> data) {
    int progress = data[2];
    print("progress...$progress");
    if (progress < 99 && progress > 1) {
      MessageHelper.showToast('Downloading...');
    } else if (progress > 99) {
      MessageHelper.showToast('Download completed',);
      _openDownloadedFile(context, data[0]);
    }
  }

  void _openDownloadedFile(BuildContext context, String taskId) {
    FlutterDownloader.open(taskId: taskId);
  }
}
