import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/core/states/states.dart';

sealed class DeviceEvent {
  const DeviceEvent();

  String get type;
  String get description;
}

class BatteryLevelChanged extends DeviceEvent {
  final int chargePercent;

  const BatteryLevelChanged(this.chargePercent);

  @override
  String get type => 'battery';

  @override
  String get description => chargePercent.toString();
}

class ChargingStateChanged extends DeviceEvent {
  final ChargingState state;

  const ChargingStateChanged(this.state);

  @override
  String get type => 'battery';

  @override
  String get description => state.name;
}

class PowerSavingModeChanged extends DeviceEvent {
  final bool enabled;

  const PowerSavingModeChanged(this.enabled);

  @override
  String get type => 'battery';

  @override
  String get description => enabled ? 'PS Enabled' : 'PS Disabled';
}

class NetworkStatusChanged extends DeviceEvent {
  final NetworkInfo network;

  const NetworkStatusChanged(this.network);

  @override
  String get type => 'network';

  @override
  String get description => '${network.isOnline ? 'Online' : 'Offline'} - ${network.type.title}';
}

class BluetoothStateChanged extends DeviceEvent {
  final BluetoothInfo bluetooth;

  const BluetoothStateChanged(this.bluetooth);

  @override
  String get type => 'bluetooth';

  @override
  String get description => bluetooth.state.name;
}