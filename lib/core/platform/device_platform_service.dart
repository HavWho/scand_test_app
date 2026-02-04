import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/domain/events/device_event.dart';

abstract class DevicePlatformService {
  Future<DeviceInfo> getDeviceInfo();
  Future<NetworkInfo> getNetworkInfo();
  Future<BatteryInfo> getBatteryInfo();
  Future<BluetoothInfo> getBluetoothInfo();

  Future<DeviceDataSnapshot> getCurrentState();

  Stream<DeviceEvent> observeEvents();

  Future<void> startMonitoring(Duration interval);
  Future<void> stopMonitoring();
}