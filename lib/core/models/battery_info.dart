import 'package:scand_test_app/core/models/charging_state.dart';

class BatteryInfo {
  final int chargePercent;
  final ChargingState chargingState;

  const BatteryInfo({required this.chargePercent, required this.chargingState});

  bool get isCharging => chargingState is Charging;

  BatteryInfo copyWith({
    int? chargePercent,
    ChargingState? chargingState,
  }) {
    return BatteryInfo(
      chargePercent: chargePercent ?? this.chargePercent,
      chargingState: chargingState ?? this.chargingState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BatteryInfo &&
              runtimeType == other.runtimeType &&
              chargePercent == other.chargePercent &&
              chargingState == other.chargingState;

  @override
  int get hashCode => chargePercent.hashCode ^ chargingState.hashCode;

  @override
  String toString() {
    return 'BatteryInfo(level: $chargePercent, chargingState: $chargingState)';
  }
}