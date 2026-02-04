import 'package:scand_test_app/core/models/device_data_snapshot.dart';
import 'package:scand_test_app/domain/events/device_event.dart';

sealed class DashboardEvent {}

class DashboardInit extends DashboardEvent {}

class SnapshotReceived extends DashboardEvent {
  final DeviceDataSnapshot snapshot;

  SnapshotReceived(this.snapshot);
}

class MonitoringToggled extends DashboardEvent {
  final bool enabled;

  MonitoringToggled(this.enabled);
}

class UpdateIntervalChanged extends DashboardEvent {
  final Duration interval;

  UpdateIntervalChanged(this.interval);
}

class DeviceEventReceived extends DashboardEvent {
  final DeviceEvent event;

  DeviceEventReceived(this.event);
}