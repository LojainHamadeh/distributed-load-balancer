// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/load_balancer_controller.dart';

// class HomeView extends GetView<LoadBalancerController> {

//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(

//       appBar: AppBar(
//         title: const Text(
//           "Load Balancer Simulator",
//         ),
//       ),

//       body: Obx(() {

//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [

//               Expanded(
//                 flex: 2,
//                 child: ListView.builder(
//                   itemCount:
//                       controller.servers.length,
//                   itemBuilder: (_, index) {

//                     final server =
//                         controller.servers[index];

//                     return Card(
//                       child: ListTile(

//                         title:
//                             Text(server.name),

//                         subtitle: Text(
//                           "Requests: ${server.currentLoad}",
//                         ),

//                         trailing:
//                             Switch(
//                           value:
//                               server.isActive,
//                           onChanged: (_) {

//                             controller
//                                 .toggleServer(
//                                     index);
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               ElevatedButton(
//                 onPressed: () {

//                   controller.sendRequest();
//                 },
//                 child: const Text(
//                   "Send Request",
//                 ),
//               ),

//               const SizedBox(height: 20),

//               const Text(
//                 "Request Logs",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight:
//                       FontWeight.bold,
//                 ),
//               ),

//               Expanded(
//                 flex: 3,
//                 child: ListView.builder(
//                   itemCount:
//                       controller.logs.length,
//                   itemBuilder: (_, index) {

//                     return ListTile(
//                       title: Text(
//                         controller.logs[index],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Enum/load_balancer_strategy.dart';
import '../controllers/load_balancer_controller.dart';

class HomeView extends GetView<LoadBalancerController> {

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Load Balancer Simulator",
        ),
      ),

      body: Obx(() {

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              DropdownButton<LoadBalancerStrategy>(

                value:
                    controller.strategy.value,

                isExpanded: true,

                items:
                    LoadBalancerStrategy.values
                        .map((strategy) {

                  return DropdownMenuItem(

                    value: strategy,

                    child: Text(
                      strategy.name,
                    ),
                  );
                }).toList(),

                onChanged: (value) {

                  controller.strategy.value =
                      value!;
                },
              ),

              const SizedBox(height: 15),

              Expanded(
                flex: 2,
                child: ListView.builder(

                  itemCount:
                      controller.servers.length,

                  itemBuilder: (_, index) {

                    final server =
                        controller.servers[index];

                    return Card(

                      child: ListTile(

                        title:
                            Text(server.name),

                        subtitle: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              "Load: ${server.currentLoad}",
                            ),

                            Text(
                              server.isActive
                                  ? "ONLINE"
                                  : "OFFLINE",
                            ),
                          ],
                        ),

                        trailing: Switch(

                          value:
                              server.isActive,

                          onChanged: (_) {

                            controller
                                .toggleServer(
                                    index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextField(
  controller:
      controller.userIdController,

  decoration: const InputDecoration(
    labelText: "User ID",
    border: OutlineInputBorder(),
  ),
),

              const SizedBox(height: 10),

              Row(

                children: [

                  Expanded(
                    child: ElevatedButton(
  onPressed: () {

    controller.sendRequest(
      controller
          .userIdController.text,
    );
  },

  child: const Text(
    "Send Request",
  ),
)
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(

                      onPressed: () {

                        controller
                            .resetLoads();
                      },

                      child: const Text(
                        "Reset",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                "Strategy : ${controller.strategy.value.name}",
                style: const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Request Logs",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              Expanded(
                flex: 3,
                child: ListView.builder(

                  itemCount:
                      controller.logs.length,

                  itemBuilder: (_, index) {

                    return ListTile(

                      leading: const Icon(
                        Icons.send,
                      ),

                      title: Text(
                        controller.logs[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}