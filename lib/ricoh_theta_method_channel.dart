import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ricoh_theta/models/device_info.dart';
import 'package:ricoh_theta/models/image_infoes.dart';
import 'package:ricoh_theta/models/storage_info.dart';

import 'ricoh_theta_platform_interface.dart';

class MethodChannelRicohTheta extends RicohThetaPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('ricoh_theta');

  @visibleForTesting
  static const EventChannel livePreviewChannel =
      EventChannel('ricoh_theta/preview');

  @visibleForTesting
  static const EventChannel downloadChannel =
      EventChannel('ricoh_theta/download');

  @override
  Future setTargetIp(String? ipAddress) async {
    return methodChannel.invokeMethod<String>('setTargetIp', {
      'ipAddress': ipAddress ?? '192.168.1.1',
    });
  }

  @override
  Future disconnect() {
    return methodChannel.invokeMethod<String>('disconnect');
  }

  @override
  Future update() {
    return methodChannel.invokeMethod('update');
  }

  @override
  Future<num?> batteryLevel() {
    return methodChannel.invokeMethod<num>('batteryLevel');
  }

  @override
  Future startLiveView(num fps) {
    return methodChannel.invokeMethod<String>('startLiveView', {
      'fps': fps,
    });
  }

  @override
  Future<StorageInfo?> getStorageInfo() async {
    final data =
        await methodChannel.invokeMapMethod<String, num>('getStorageInfo');
    return data != null ? StorageInfo.fromMap(data) : null;
  }

  @override
  Future<List<ImageInfoes>> getImageInfoes() async {
    final data = await methodChannel.invokeMethod<List>('getImageInfoes');
    if (data == null) {
      return [];
    }

    final map = data.map((imageData) => Map<String, dynamic>.from(imageData));
    return map.map((image) => ImageInfoes.fromMap(image)).toList();
  }

  @override
  Future<DeviceInfo?> getDeviceInfo() async {
    final data =
        await methodChannel.invokeMapMethod<String, String>('getDeviceInfo');
    return data != null ? DeviceInfo.fromMap(data) : null;
  }

  @override
  Future<String?> takePicture() {
    return methodChannel.invokeMethod<String>('takePicture');
  }

  @override
  Stream<Uint8List>? listenCameraImages() {
    return livePreviewChannel.receiveBroadcastStream().transform(
        StreamTransformer<dynamic, Uint8List>.fromHandlers(
            handleData: (data, sink) {
      sink.add(data);
    }));
  }

  @override
  Stream<num>? listenDownloadProgress() {
    return downloadChannel.receiveBroadcastStream().transform(
        StreamTransformer<dynamic, num>.fromHandlers(handleData: (data, sink) {
      sink.add(data);
    }));
  }

  @override
  Future adjustLiveViewFps(num fps) {
    return methodChannel.invokeMethod<String>('adjustLiveViewFps', {
      'fps': fps,
    });
  }

  @override
  Future pauseLiveView() async {
    return methodChannel.invokeMethod<String>('pauseLiveView');
  }

  @override
  Future stopLiveView() async {
    return methodChannel.invokeMethod<String>('stopLiveView');
  }

  @override
  Future resumeLiveView() async {
    return methodChannel.invokeMethod<String>('resumeLiveView');
  }

  @override
  Future<bool?> removeImageWithFileId(String fileId) async {
    return methodChannel.invokeMethod<bool>('removeImageWithFileId', {
      'fileId': fileId,
    });
  }

  @override
  Future<File?> getImage(String fileId) async {
    final tmpPath = await methodChannel.invokeMethod<String>('getImage', {
      'fileId': fileId,
    });

    return tmpPath != null ? File(tmpPath) : null;
  }
}
