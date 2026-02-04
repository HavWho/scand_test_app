import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/core/states/states.dart';
import 'package:scand_test_app/core/utils/network_type.dart';

class DashboardState {
  final bool monitoringEnabled;
  final Duration updateInterval;

  final DeviceInfo device;
  final BatteryInfo battery;
  final NetworkInfo network;
  final BluetoothInfo bluetooth;
  final bool isPowerSavingEnabled;

  const DashboardState({
    required this.monitoringEnabled,
    required this.updateInterval,
    required this.device,
    required this.battery,
    required this.network,
    required this.bluetooth,
    required this.isPowerSavingEnabled,
  });

  DashboardState copyWith({
    bool? monitoringEnabled,
    Duration? updateInterval,
    DeviceInfo? device,
    BatteryInfo? battery,
    NetworkInfo? network,
    BluetoothInfo? bluetooth,
    bool? isPowerSavingEnabled,
  }) => DashboardState(
    monitoringEnabled: monitoringEnabled ?? this.monitoringEnabled,
    updateInterval: updateInterval ?? this.updateInterval,
    device: device ?? this.device,
    battery: battery ?? this.battery,
    network: network ?? this.network,
    bluetooth: bluetooth ?? this.bluetooth,
    isPowerSavingEnabled: isPowerSavingEnabled ?? this.isPowerSavingEnabled,
  );

  factory DashboardState.initial() {
    return DashboardState(
      monitoringEnabled: false,
      updateInterval: const Duration(seconds: 5),
      device: DeviceInfo(deviceVendor: 'deviceVendor', deviceModel: 'deviceModel', osName: 'osName', osVersion: 'osVersion'),
      battery: BatteryInfo(chargePercent: 0, chargingState: const ChargingStateUnknown()),
      network: NetworkInfo(isOnline: false, type: const UnknownNetwork()),
      bluetooth: BluetoothInfo(state: const BluetoothUnknown()),
      isPowerSavingEnabled: false,
    );
  }

  factory DashboardState.fromSnapshot(DeviceDataSnapshot snapshot) {
    return DashboardState(
      monitoringEnabled: false,
      updateInterval: const Duration(seconds: 5),
      device: snapshot.deviceInfo,
      battery: snapshot.batteryInfo,
      network: snapshot.networkInfo,
      bluetooth: snapshot.bluetoothInfo,
      isPowerSavingEnabled: snapshot.isPowerSavingEnabled,
    );
  }

  bool differsFromSnapshot(DeviceDataSnapshot snapshot) {
    return battery != snapshot.batteryInfo ||
        network != snapshot.networkInfo ||
        bluetooth != snapshot.bluetoothInfo ||
        isPowerSavingEnabled != snapshot.isPowerSavingEnabled;
  }
}
