import 'package:scand_test_app/core/utils/network_type.dart';

sealed class NetworkState {
  const NetworkState();
}

class Online extends NetworkState {
  final NetworkType type;

  const Online(this.type);
}

class Offline extends NetworkState {
  const Offline();
}