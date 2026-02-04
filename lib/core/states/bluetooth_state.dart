import 'package:scand_test_app/core/utils/strings.dart';

sealed class BluetoothState {
  const BluetoothState();

  String get name;
}

class BluetoothOn extends BluetoothState {
  const BluetoothOn();

  @override
  String get name => 'Bluetooth On';
}

class BluetoothOff extends BluetoothState {
  const BluetoothOff();

  @override
  String get name => 'Bluetooth Off';
}

class Connected extends BluetoothState {
  const Connected();

  @override
  String get name => 'Bluetooth Connected';
}

class Disconnected extends BluetoothState {
  const Disconnected();

  @override
  String get name => 'Bluetooth Disconnected';
}

class TurningOn extends BluetoothState {
  const TurningOn();

  @override
  String get name => 'Bluetooth is Turning On';
}

class TurningOff extends BluetoothState {
  const TurningOff();

  @override
  String get name => 'Bluetooth is Turning Off';
}

class BluetoothUnavailable extends BluetoothState {
  const BluetoothUnavailable();

  @override
  String get name => 'Bluetooth Unavailable';
}

class BluetoothUnknown extends BluetoothState {
  const BluetoothUnknown();

  @override
  String get name => Strings.unknown;
}