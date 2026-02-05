class DetailEventEntry {
  final DateTime timestamp;
  final String type;
  final String description;

  const DetailEventEntry({required this.timestamp, required this.type, required this.description});

  String get getNativeMethod => switch (type) {
    'battery' => 'getBatteryInfo',
    'network' => 'getNetworkInfo',
    'bluetooth' => 'getBluetoothInfo',
    _ => throw UnimplementedError(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailEventEntry &&
          runtimeType == other.runtimeType &&
          timestamp == other.timestamp &&
          type == other.type &&
          description == other.description;

  @override
  int get hashCode => Object.hash(timestamp, type, description);

  @override
  String toString() {
    return 'DetailEventEntry(timestamp: $timestamp, type: $type, description: $description)';
  }
}
