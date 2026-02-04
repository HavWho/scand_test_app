import 'package:scand_test_app/core/states/bluetooth_state.dart';

class BluetoothInfo {
  final BluetoothState state;

  const BluetoothInfo({required this.state});

  bool get isEnabled => state is BluetoothOn;

  BluetoothInfo copyWith({
    BluetoothState? state,
  }) {
    return BluetoothInfo(
      state: state ?? this.state,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BluetoothInfo &&
              runtimeType == other.runtimeType &&
              state.runtimeType == other.state.runtimeType;

  @override
  int get hashCode => state.runtimeType.hashCode;

  @override
  String toString() {
    return 'BluetoothInfo(state: $state)';
  }
}