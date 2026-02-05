import 'package:scand_test_app/features/details/utils/detail_event_entry.dart';

sealed class DetailsEvent {
  const DetailsEvent();
}

class DetailsInit extends DetailsEvent {}

class NewDataEvent extends DetailsEvent {
  final DetailEventEntry entry;

  const NewDataEvent(this.entry);
}

class MonitoringToggled extends DetailsEvent {
  final bool enabled;

  const MonitoringToggled(this.enabled);
}
