import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/interceptor_controller.dart';
import '../models/circuit_state.dart';

class HomeView2 extends GetView<InterceptorController> {

  const HomeView2({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Fault Tolerant Interceptor",
        ),
        centerTitle: true,
      ),

      body: Obx(() {

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(

            children: [

              /// SERVERS
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

                        title: Text(
                          server.name,
                        ),

                        subtitle: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Status : ${server.isOnline ? "ONLINE" : "OFFLINE"}",
                            ),

                            Text(
                              "Failures : ${server.failureCount}",
                            ),

                            Text(
                              "Circuit : ${_circuitText(server.circuitState)}",
                            ),
                          ],
                        ),

                        trailing: Switch(

                          value: server.isOnline,

                          onChanged: (_) {

                            controller.toggleServer(
                              index,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              /// BUTTONS
              Row(

                children: [

                  Expanded(
                    child: ElevatedButton(

                      onPressed: () {

                        controller.sendRequest();
                      },

                      child: const Text(
                        "Send Request",
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(

                      onPressed: () {

                        controller.resetSystem();
                      },

                      child: const Text(
                        "Reset",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Logs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                flex: 3,
                child: ListView.builder(

                  itemCount:
                      controller.logs.length,

                  itemBuilder: (_, index) {

                    return Card(

                      child: ListTile(

                        leading: const Icon(
                          Icons.info_outline,
                        ),

                        title: Text(
                          controller.logs[index],
                        ),
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

  String _circuitText(
      CircuitState state) {

    switch (state) {

      case CircuitState.closed:
        return "CLOSED";

      case CircuitState.open:
        return "OPEN";

      case CircuitState.halfOpen:
        return "HALF OPEN";
    }
  }
}