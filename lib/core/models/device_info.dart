class DeviceInfo {
  final String deviceVendor;
  final String deviceModel;
  final String osName;
  final String osVersion;

  const DeviceInfo({required this.deviceVendor, required this.deviceModel, required this.osName, required this.osVersion});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceInfo &&
          runtimeType == other.runtimeType &&
          deviceModel == other.deviceModel &&
          osName == other.osName &&
          osVersion == other.osVersion;

  @override
  int get hashCode => Object.hash(deviceVendor, deviceModel, osName, osVersion);

  @override
  String toString() {
    return 'DeviceInfo(deviceVendor: $deviceVendor, deviceModel: $deviceModel, os: $osName, version: $osVersion)';
  }
}
