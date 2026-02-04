import 'battery_info.dart';
import 'bluetooth_info.dart';
import 'device_info.dart';
import 'network_info.dart';

class DeviceDataSnapshot {
  final DeviceInfo deviceInfo;
  final BatteryInfo batteryInfo;
  final NetworkInfo networkInfo;
  final BluetoothInfo bluetoothInfo;
  final bool isPowerSavingEnabled;

  const DeviceDataSnapshot({
    required this.deviceInfo,
    required this.batteryInfo,
    required this.networkInfo,
    required this.bluetoothInfo,
    required this.isPowerSavingEnabled,
  });

  DeviceDataSnapshot copyWith({
    DeviceInfo? deviceInfo,
    BatteryInfo? batteryInfo,
    NetworkInfo? networkInfo,
    BluetoothInfo? bluetoothInfo,
    bool? isPowerSavingEnabled,
  }) {
    return DeviceDataSnapshot(
      deviceInfo: deviceInfo ?? this.deviceInfo,
      batteryInfo: batteryInfo ?? this.batteryInfo,
      networkInfo: networkInfo ?? this.networkInfo,
      bluetoothInfo: bluetoothInfo ?? this.bluetoothInfo,
      isPowerSavingEnabled: isPowerSavingEnabled ?? this.isPowerSavingEnabled,
    );
  }

  factory DeviceDataSnapshot.fromMap(Map<String, dynamic> map) => DeviceDataSnapshot(
    deviceInfo: map['deviceInfo'],
    batteryInfo: map['batteryInfo'],
    networkInfo: map['networkInfo'],
    bluetoothInfo: map['bluetoothInfo'],
    isPowerSavingEnabled: map['isPowerSavingEnabled'],
  );

  @override
  String toString() {
    return 'DeviceStateSnapshot(deviceInfo: $deviceInfo, batteryInfo: $batteryInfo, '
        'networkInfo: $networkInfo, bluetoothInfo: $bluetoothInfo, '
        'powerSavingEnabled: $isPowerSavingEnabled)';
  }
}
