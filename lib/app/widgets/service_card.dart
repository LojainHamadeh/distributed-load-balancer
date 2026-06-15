// import 'package:flutter/material.dart';

// class ServiceCard extends StatelessWidget {

//   final String name;

//   final bool isAlive;

//   final String heartbeat;

//   final VoidCallback action;

//   final bool isRunning;

//   const ServiceCard({
//     super.key,
//     required this.name,
//     required this.isAlive,
//     required this.heartbeat,
//     required this.action,
//     required this.isRunning,
//   });

//   @override
//   Widget build(BuildContext context) {

//     return Card(
//       child: ListTile(
//         title: Text(name),

//         subtitle: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [

//             Text(
//               isAlive
//                   ? "Alive"
//                   : "Down",
//             ),

//             Text(
//               heartbeat,
//             ),
//           ],
//         ),

//         trailing: ElevatedButton(
//           onPressed: action,
//           child: Text(
//             isRunning
//                 ? "Stop"
//                 : "Start",
//           ),
//         ),
//       ),
//     );
//   }
// }