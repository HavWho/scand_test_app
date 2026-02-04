sealed class ChargingState {
  const ChargingState();
}

class Charging extends ChargingState {
  const Charging();
}

class Unplugged extends ChargingState {
  const Unplugged();
}

class Charged extends ChargingState {
  const Charged();
}

class Unknown extends ChargingState {
  const Unknown();
}