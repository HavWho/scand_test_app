import 'package:scand_test_app/features/details/utils/detail_event_entry.dart';

class DetailsState {
  final List<DetailEventEntry> events;
  final bool monitoringEnabled;
  final String dataType;

  const DetailsState({
    this.events = const [],
    this.monitoringEnabled = false,
    this.dataType = '',
  });

  DetailsState copyWith({List<DetailEventEntry>? events, bool? monitoringEnabled, String? dataType}) {
    return DetailsState(
      events: events ?? this.events,
      monitoringEnabled: monitoringEnabled ?? this.monitoringEnabled,
      dataType: dataType ?? this.dataType,
    );
  }
}
