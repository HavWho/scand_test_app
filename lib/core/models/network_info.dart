import 'package:scand_test_app/core/utils/network_type.dart';

class NetworkInfo {
  final bool isOnline;
  final NetworkType type;

  const NetworkInfo({required this.isOnline, required this.type});

  bool get isWiFi => type is WiFi;

  bool get isCellular => type is Cellular;

  NetworkInfo copyWith({bool? isOnline, NetworkType? type}) =>
      NetworkInfo(isOnline: isOnline ?? this.isOnline, type: type ?? this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkInfo &&
          runtimeType == other.runtimeType &&
          isOnline == other.isOnline &&
          type.runtimeType == other.type.runtimeType;

  @override
  int get hashCode => Object.hash(isOnline, type.runtimeType);

  @override
  String toString() {
    return 'NetworkInfo(isOnline: $isOnline, type: $type)';
  }
}
