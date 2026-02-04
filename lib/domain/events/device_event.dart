import 'package:scand_test_app/core/models/models.dart';

sealed class DeviceEvent {
  const DeviceEvent();
}

class BatteryLevelChanged extends DeviceEvent {
  final int level;
  const BatteryLevelChanged(this.level);
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