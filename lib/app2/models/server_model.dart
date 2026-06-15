import 'circuit_state.dart';

class ServerModel {
  String name;

  bool isOnline;

  CircuitState circuitState;

  int failureCount;

  DateTime? circuitOpenedAt;

  ServerModel({
    required this.name,
    this.isOnline = true,
    this.circuitState = CircuitState.closed,
    this.failureCount = 0,
    this.circuitOpenedAt,
  });
}