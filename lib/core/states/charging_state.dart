import 'package:scand_test_app/core/utils/strings.dart';

sealed class ChargingState {
  const ChargingState();

  String get name;
}

class Charging extends ChargingState {
  const Charging();

  @override
  String get name => 'Charging';
}

class Unplugged extends ChargingState {
  const Unplugged();

  @override
  String get name => 'Unplugged';
}

class Charged extends ChargingState {
  const Charged();

  @override
  String get name => 'Battery is Full';
}

class ChargingStateUnknown extends ChargingState {
  const ChargingStateUnknown();

  @override
  String get name => Strings.unknown;
}