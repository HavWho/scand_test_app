import 'dart:async';

import 'package:scand_test_app/core/platform/device_platform_service.dart';
import 'package:scand_test_app/domain/events/device_event.dart';

import 'dashboard_events.dart';
import 'dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DevicePlatformService _service;
  StreamSubscription? _subscription;
  Timer? _pollingTimer;

  DashboardBloc({required DevicePlatformService service})
    : _service = service,
      super(DashboardState.initial()) {
    on<DashboardInit>(_onInit);
    on<MonitoringToggled>(_onMonitoringToggled);
    on<UpdateIntervalChanged>(_onIntervalChanged);
    on<DeviceEventReceived>(_onDeviceEventReceived);
    on<SnapshotReceived>(_onSnapshotReceived);
  }

  Future<void> _onInit(DashboardInit event, Emitter<DashboardState> emit) async {
    final snapshot = await _service.getCurrentState();
    emit(DashboardState.fromSnapshot(snapshot));
  }

  void _onMonitoringToggled(MonitoringToggled event, Emitter<DashboardState> emit) {
    emit(state.copyWith(monitoringEnabled: event.enabled));

    if (event.enabled) {
      _startPolling();
    } else {
      _stopPolling();
    }
  }

  void _onIntervalChanged(UpdateIntervalChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(updateInterval: event.interval));
  }

  void _startPolling() {
    if (_subscription != null || _pollingTimer != null) return;

    _subscription = _service.observeEvents().listen(
      (event) => add(DeviceEventReceived(event)),
      onError: (_) {},
      cancelOnError: false,
    );

    _pollingTimer = Timer.periodic(state.updateInterval, (_) async {
      final snapshot = await _service.getCurrentState();
      add(SnapshotReceived(snapshot));
    });
  }

  void _stopPolling() {
    _subscription?.cancel();
    _subscription = null;
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void _onSnapshotReceived(SnapshotReceived event, Emitter<DashboardState> emit) {
    if (!state.differsFromSnapshot(event.snapshot)) return;

    emit(
      state.copyWith(
        battery: event.snapshot.batteryInfo,
        network: event.snapshot.networkInfo,
        bluetooth: event.snapshot.bluetoothInfo,
        isPowerSavingEnabled: event.snapshot.isPowerSavingEnabled,
      ),
    );
  }

  void _onDeviceEventReceived(DeviceEventReceived event, Emitter<DashboardState> emit) {
    final e = event.event;
    switch (e) {
      case BatteryLevelChanged():
        if (state.battery.chargePercent != e.chargePercent) {
          emit(state.copyWith(battery: state.battery.copyWith(chargePercent: e.chargePercent)));
        }
      case ChargingStateChanged():
        if (state.battery.chargingState != e.state) {
          emit(state.copyWith(battery: state.battery.copyWith(chargingState: e.state)));
        }
      case PowerSavingModeChanged():
        if (state.isPowerSavingEnabled != e.enabled) {
          emit(state.copyWith(isPowerSavingEnabled: e.enabled));
        }
      case NetworkStatusChanged():
        if (state.network != e.network) {
          emit(
            state.copyWith(
              network: state.network.copyWith(isOnline: e.network.isOnline, type: e.network.type),
            ),
          );
        }
      case BluetoothStateChanged():
        if (state.bluetooth.state != e.bluetooth.state) {
          emit(state.copyWith(bluetooth: state.bluetooth.copyWith(state: e.bluetooth.state)));
        }
    }
  }
}
