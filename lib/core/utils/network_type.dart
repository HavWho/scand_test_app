sealed class NetworkType {
  const NetworkType();

  String get title;
}

class WiFi extends NetworkType {
  const WiFi();

  @override
  String get title => 'Wifi';
}

class Cellular extends NetworkType {
  const Cellular();

  @override
  String get title => 'Cellular';
}

class UnknownNetwork extends NetworkType {
  const UnknownNetwork();

  @override
  String get title => 'UnknownNetwork';
}