import 'package:flutter/services.dart';

import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/core/platform/device_platform_service.dart';
import 'package:scand_test_app/data/mappers/device_data_mapper.dart';
import 'package:scand_test_app/domain/events/device_event.dart';

class DevicePlatformServiceImpl implements DevicePlatformService {
  static const MethodChannel _methodChannel = MethodChannel('scand_mobile_monitor/methods');
  static const EventChannel _eventChannel = EventChannel('scand_mobile_monitor/events');

  @override
  Future<BatteryInfo> getBatteryInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getBatteryInfo');
    final Map<String, dynamic> result =
        Map<String, dynamic>.from(raw as Map);
    return DeviceDataMapper.toBatteryInfo(result['batteryInfo']);
  }

  @override
  Future<BluetoothInfo> getBluetoothInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getBluetoothInfo');
    final Map<String, dynamic> result =
    Map<String, dynamic>.from(raw as Map);
    return DeviceDataMapper.toBluetoothInfo(result['bluetoothInfo']);
  }

  @override
  Future<DeviceInfo> getDeviceInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getDeviceInfo');
    final Map<String, dynamic> result =
    Map<String, dynamic>.from(raw as Map);
    return DeviceDataMapper.toDeviceInfo(result['deviceInfo']);
  }

  @override
  Future<NetworkInfo> getNetworkInfo() async {
    final raw = await _methodChannel.invokeMapMethod('getNetworkInfo');
    final Map<String, dynamic> result =
    Map<String, dynamic>.from(raw as Map);
    return DeviceDataMapper.toNetworkInfo(result['networkInfo']);
  }

  @override
  Future<DeviceDataSnapshot> getCurrentState() async {
    final raw = await _methodChannel.invokeMethod('getCurrentState');

    if (raw == null || raw is! Map) {
      throw Exception('Platform did not return a valid map for getCurrentState');
    }

    final Map<String, dynamic> result = Map<String, dynamic>.from(raw);

    return DeviceDataMapper.toSnapshot(result);
  }

  @override
  Stream<DeviceEvent> observeEvents() {
    return _eventChannel.receiveBroadcastStream().map((event) {
      final data = Map<String, dynamic>.from(event);
      return DeviceDataMapper.toDeviceEvent(data);
    });
  }

  @override
  Future<void> startMonitoring(Duration interval) async {
    _methodChannel.invokeMethod('monitor_start', {'interval': interval});
  }

  @override
  Future<void> stopMonitoring() async {
    _methodChannel.invokeMethod('stopMonitoring');
  }
}
