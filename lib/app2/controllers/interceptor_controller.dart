import 'package:get/get.dart';

import '../models/circuit_state.dart';
import '../models/server_model.dart';

class InterceptorController extends GetxController {

  RxList<ServerModel> servers = <ServerModel>[
    ServerModel(name: "Server 1"),
    ServerModel(name: "Server 2"),
    ServerModel(name: "Server 3"),
  ].obs;

  RxList<String> logs = <String>[].obs;

  int currentIndex = 0;

  void sendRequest() {

    logs.insert(
      0,
      "New Request Started",
    );

    bool success = _tryRequest();

    if (!success) {

      logs.insert(
        0,
        "Request Failed: No Available Servers",
      );
    }

    servers.refresh();
  }

  bool _tryRequest() {

    for (int i = 0; i < servers.length; i++) {

      ServerModel server =
          servers[currentIndex];

      currentIndex =
          (currentIndex + 1) %
          servers.length;

      /// هل يجب تحويل OPEN إلى HALF-OPEN؟
      _checkCircuitRecovery(server);

      /// إذا كان الـ Circuit ما زال OPEN نتجاوزه
      if (server.circuitState ==
          CircuitState.open) {

        logs.insert(
          0,
          "${server.name} Circuit OPEN → Skipped",
        );

        continue;
      }

      logs.insert(
        0,
        "Trying ${server.name}",
      );

      bool requestSucceeded =
          _simulateRequest(server);

      /// نجح الطلب
      if (requestSucceeded) {

        logs.insert(
          0,
          "Success → ${server.name}",
        );

        if (server.circuitState ==
            CircuitState.halfOpen) {

          logs.insert(
            0,
            "${server.name} recovered successfully",
          );
        }

        server.failureCount = 0;

        server.circuitState =
            CircuitState.closed;

        server.circuitOpenedAt =
            null;

        return true;
      }

      /// فشل الطلب
      logs.insert(
        0,
        "Failure → ${server.name}",
      );

      server.failureCount++;

      logs.insert(
        0,
        "Failure Count = ${server.failureCount}",
      );

      /// إذا كنا في HALF-OPEN وفشل الطلب
      if (server.circuitState ==
          CircuitState.halfOpen) {

        server.circuitState =
            CircuitState.open;

        server.circuitOpenedAt =
            DateTime.now();

        logs.insert(
          0,
          "${server.name} HALF-OPEN failed → OPEN again",
        );

        logs.insert(
          0,
          "Retrying...",
        );

        continue;
      }

      /// فتح الـ Circuit بعد 3 فشل متتالية
      if (server.failureCount >= 3) {

        server.circuitState =
            CircuitState.open;

        server.circuitOpenedAt =
            DateTime.now();

        logs.insert(
          0,
          "${server.name} Circuit OPENED",
        );
      }

      logs.insert(
        0,
        "Retrying...",
      );
    }

    return false;
  }

  bool _simulateRequest(
      ServerModel server) {

    /// إذا كان السيرفر مطفأ نفشل الطلب
    if (!server.isOnline) {

      return false;
    }

    return true;
  }

  void _checkCircuitRecovery(
      ServerModel server) {

    if (server.circuitState !=
        CircuitState.open) {

      return;
    }

    if (server.circuitOpenedAt ==
        null) {

      return;
    }

    final secondsPassed =
        DateTime.now()
            .difference(
              server.circuitOpenedAt!,
            )
            .inSeconds;

    /// بعد 10 ثوانٍ نجرب السيرفر مرة واحدة
    if (secondsPassed >= 10) {

      server.circuitState =
          CircuitState.halfOpen;

      logs.insert(
        0,
        "${server.name} Circuit HALF-OPEN",
      );
    }
  }

  void toggleServer(int index) {

    servers[index].isOnline =
        !servers[index].isOnline;

    logs.insert(
      0,
      "${servers[index].name} "
      "${servers[index].isOnline ? "ONLINE" : "OFFLINE"}",
    );

    servers.refresh();
  }

  void resetSystem() {

    for (var server in servers) {

      server.isOnline = true;

      server.failureCount = 0;

      server.circuitState =
          CircuitState.closed;

      server.circuitOpenedAt =
          null;
    }

    logs.clear();

    currentIndex = 0;

    servers.refresh();
  }
}