import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scand_test_app/core/platform/device_platform_service.dart';
import 'package:scand_test_app/domain/events/device_event.dart';
import 'package:scand_test_app/features/details/utils/detail_event_entry.dart';
import 'details_events.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DevicePlatformService _service;
  final String _dataType;
  StreamSubscription<DeviceEvent>? _subscription;

  DetailsBloc({
    required String dataType,
    required DevicePlatformService service,
  })  : _dataType = dataType,
        _service = service,
        super(DetailsState()) {
    on<DetailsInit>(_onInit);
    on<NewDataEvent>(_onNewData);
    on<MonitoringToggled>(_onToggleMonitoring);
  }

  void _onInit(DetailsInit event, Emitter<DetailsState> emit) {
    emit(state.copyWith(dataType: _dataType));
  }

  void _onNewData(NewDataEvent event, Emitter<DetailsState> emit) {
    final updated = List<DetailEventEntry>.from(state.events)
      ..insert(0, event.entry);

    if (updated.length > 15) {
      updated.removeRange(15, updated.length);
    }

    emit(state.copyWith(events: updated));
  }

  Future<void> _onToggleMonitoring(
      MonitoringToggled event,
      Emitter<DetailsState> emit,
      ) async {
    emit(state.copyWith(monitoringEnabled: event.enabled));

    if (event.enabled) {
      await _service.startMonitoring();
      _subscription?.cancel();
      _subscription = _service.observeEvents().listen(_onDeviceEvent);
    } else {
      await _service.stopMonitoring();
      await _subscription?.cancel();
      _subscription = null;
    }
  }

  void _onDeviceEvent(DeviceEvent event) {
    if (event.type != state.dataType) return;

    add(
      NewDataEvent(
        DetailEventEntry(
          timestamp: DateTime.timestamp(),
          type: event.runtimeType.toString(),
          description: event.description,
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
