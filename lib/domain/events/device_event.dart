import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/core/states/states.dart';

sealed class DeviceEvent {
  const DeviceEvent();
}

class BatteryLevelChanged extends DeviceEvent {
  final int chargePercent;

  const BatteryLevelChanged(this.chargePercent);
}

class ChargingStateChanged extends DeviceEvent {
  final ChargingState state;

  const ChargingStateChanged(this.state);
}

class PowerSavingModeChanged extends DeviceEvent {
  final bool enabled;

  const PowerSavingModeChanged(this.enabled);
}

class NetworkStatusChanged extends DeviceEvent {
  final NetworkInfo network;

  const NetworkStatusChanged(this.network);
}

class BluetoothStateChanged extends DeviceEvent {
  final BluetoothInfo bluetooth;

  const BluetoothStateChanged(this.bluetooth);
}