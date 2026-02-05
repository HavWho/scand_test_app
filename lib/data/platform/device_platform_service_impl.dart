import 'package:flutter/services.dart';
import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/core/platform/device_platform_service.dart';
import 'package:scand_test_app/data/mappers/device_data_mapper.dart';
import 'package:scand_test_app/domain/events/device_event.dart';

class DevicePlatformServiceImpl implements DevicePlatformService {
  static const MethodChannel _methodChannel =
  MethodChannel('scand_mobile_monitor/methods');

  static const EventChannel _eventChannel =
  EventChannel('scand_mobile_monitor/events');

  @override
  Stream<DeviceEvent> observeEvents() {
    return _eventChannel
        .receiveBroadcastStream()
        .where((e) => e is Map)
        .map((e) => DeviceDataMapper.toDeviceEvent(
      Map<String, dynamic>.from(e as Map),
    ));
  }

  @override
  Future<void> startMonitoring() async {
    await _methodChannel.invokeMethod('startMonitoring');
  }

  @override
  Future<void> stopMonitoring() async {
    await _methodChannel.invokeMethod('stopMonitoring');
  }

  @override
  Future<BatteryInfo> getBatteryInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getBatteryInfo');
    return DeviceDataMapper.toBatteryInfo(
      Map<String, dynamic>.from(raw as Map),
    );
  }

  @override
  Future<BluetoothInfo> getBluetoothInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getBluetoothInfo');
    return DeviceDataMapper.toBluetoothInfo(
      Map<String, dynamic>.from(raw as Map),
    );
  }

  @override
  Future<NetworkInfo> getNetworkInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getNetworkInfo');
    return DeviceDataMapper.toNetworkInfo(
      Map<String, dynamic>.from(raw as Map),
    );
  }

  @override
  Future<DeviceInfo> getDeviceInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getDeviceInfo');
    return DeviceDataMapper.toDeviceInfo(
      Map<String, dynamic>.from(raw as Map),
    );
  }

  @override
  Future<DeviceDataSnapshot> getCurrentState() async {
    final raw = await _methodChannel.invokeMethod('getCurrentState');
    return DeviceDataMapper.toSnapshot(
      Map<String, dynamic>.from(raw as Map),
    );
  }
}
