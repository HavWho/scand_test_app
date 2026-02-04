import 'package:scand_test_app/core/models/models.dart';

abstract class DevicePlatformService {
  Future<DeviceInfo> getDeviceInfo();
  Future<NetworkInfo> getNetworkInfo();
  Future<BatteryInfo> getBatteryInfo();
  Future<BluetoothInfo> getBluetoothInfo();

  
}