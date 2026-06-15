// import 'package:distributed/app/Enum/load_balancer_strategy.dart';
// import 'package:get/get.dart';
// import '../models/server_model.dart';

// class LoadBalancerController extends GetxController {

//   RxList<ServerModel> servers = <ServerModel>[
//     ServerModel(name: "Server 1"),
//     ServerModel(name: "Server 2"),
//     ServerModel(name: "Server 3"),
//   ].obs;

//   RxList<String> logs = <String>[].obs;
//   Rx<LoadBalancerStrategy> strategy =
//     LoadBalancerStrategy.roundRobin.obs;

//   int currentIndex = 0;
//   int requestNumber = 1;

//   void sendRequest() {

//     final activeServers =
//         servers.where((e) => e.isActive).toList();

//     if (activeServers.isEmpty) {

//       logs.insert(
//         0,
//         "No Active Servers",
//       );

//       return;
//     }

//     currentIndex =
//         currentIndex % activeServers.length;

//     final selectedServer =
//         activeServers[currentIndex];

//     selectedServer.currentLoad++;

//     logs.insert(
//       0,
//       "Request $requestNumber → ${selectedServer.name}",
//     );

//     requestNumber++;

//     currentIndex++;

    

//     servers.refresh();
//   }

//   void toggleServer(int index) {

//     servers[index].isActive =
//         !servers[index].isActive;

//     servers.refresh();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Enum/load_balancer_strategy.dart';
import '../models/server_model.dart';

class LoadBalancerController extends GetxController {
  final userIdController = TextEditingController();

  RxList<ServerModel> servers = <ServerModel>[
    ServerModel(name: "Server 1"),
    ServerModel(name: "Server 2"),
    ServerModel(name: "Server 3"),
  ].obs;

  RxList<String> logs = <String>[].obs;

  Rx<LoadBalancerStrategy> strategy =
      LoadBalancerStrategy.roundRobin.obs;

  int currentIndex = 0;
  int requestNumber = 1;

  void sendRequest(String userId) {

    final activeServers =
        servers.where((e) => e.isActive).toList();

    if (activeServers.isEmpty) {

      logs.insert(
        0,
        "No Active Servers",
      );

      return;
    }

    ServerModel selectedServer;

    switch (strategy.value) {

      case LoadBalancerStrategy.roundRobin:

        currentIndex =
            currentIndex %
            activeServers.length;

        selectedServer =
            activeServers[currentIndex];

        currentIndex++;

        break;

      case LoadBalancerStrategy.leastConnections:

        activeServers.sort(
          (a, b) =>
              a.currentLoad.compareTo(
                  b.currentLoad),
        );

        selectedServer =
            activeServers.first;

        break;

      case LoadBalancerStrategy.consistentHashing:

        int hash = userId.hashCode;

int index =
    hash.abs() %
    activeServers.length;

selectedServer =
    activeServers[index];
        break;
    }

    selectedServer.currentLoad++;

    logs.insert(
  0,
  "User: $userId → ${selectedServer.name}",
);
    requestNumber++;

    servers.refresh();
  }

  void toggleServer(int index) {

    servers[index].isActive =
        !servers[index].isActive;

    servers.refresh();
  }

  void resetLoads() {

    for (var server in servers) {
      server.currentLoad = 0;
    }

    logs.clear();

    requestNumber = 1;

    currentIndex = 0;

    servers.refresh();
  }
}