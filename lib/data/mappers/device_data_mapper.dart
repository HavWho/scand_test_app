import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/core/states/states.dart';
import 'package:scand_test_app/core/utils/network_type.dart';
import 'package:scand_test_app/core/utils/strings.dart';
import 'package:scand_test_app/domain/events/device_event.dart';

class DeviceDataMapper {
  static DeviceDataSnapshot toSnapshot(Map<String, dynamic> data) {
    return DeviceDataSnapshot(
      deviceInfo: toDeviceInfo(Map<String, dynamic>.from(data['deviceInfo'] ?? {})),
      batteryInfo: toBatteryInfo(Map<String, dynamic>.from(data['battery'] ?? {})),
      networkInfo: toNetworkInfo(Map<String, dynamic>.from(data['network'] ?? {})),
      bluetoothInfo: toBluetoothInfo(Map<String, dynamic>.from(data['bluetooth'] ?? {})),
      isPowerSavingEnabled: data['powerSaving'] ?? false,
    );
  }

  static DeviceEvent toDeviceEvent(Map<String, dynamic> data) {
    return switch (data['type']) {
      'chargePercent' => BatteryLevelChanged(data['value']),
      'chargingState' => ChargingStateChanged(data['value']),
      'powerSaving' => PowerSavingModeChanged(data['value']),
      'network' => NetworkStatusChanged(data['value']),
      'bluetooth' => BluetoothStateChanged(data['value']),
      _ => throw UnsupportedError(Strings.unknownEvent),
    };
  }

  static DeviceInfo toDeviceInfo(Map<String, dynamic> data) {
    return DeviceInfo(
      deviceVendor: data['vendor'] ?? Strings.unknown,
      deviceModel: data['model'] ?? Strings.unknown,
      osName: data['osName'] ?? Strings.unknown,
      osVersion: data['osVersion'] ?? Strings.unknown,
    );
  }

  static BatteryInfo toBatteryInfo(Map<String, dynamic> data) {
    return BatteryInfo(
      chargePercent: data['chargePercent'] ?? -999,
      chargingState: _mapChargingState(data['chargingState']),
    );
  }

  static BluetoothInfo toBluetoothInfo(Map<String, dynamic> data) {
    return BluetoothInfo(state: _mapBluetoothState(data['state'] ?? Strings.unknown));
  }

  static NetworkInfo toNetworkInfo(Map<String, dynamic> data) {
    return NetworkInfo(
      isOnline: data['isOnline'] ?? Strings.unknown,
      type: _mapNetworkType(data['type']),
    );
  }

  static ChargingState _mapChargingState(String value) => switch (value) {
    'charging' => const Charging(),
    'not_charging' => const Unplugged(),
    'full' => const Charged(),
    _ => const ChargingStateUnknown(),
  };

  static NetworkType _mapNetworkType(String value) => switch (value) {
    'wifi' => const WiFi(),
    'cellular' => const Cellular(),
    _ => const UnknownNetwork(),
  };

  static BluetoothState _mapBluetoothState(String value) => switch (value) {
    'on' => const BluetoothOn(),
    'off' => const BluetoothOff(),
    'unavailable' => const BluetoothUnavailable(),
    _ => const BluetoothUnknown(),
  };
}
