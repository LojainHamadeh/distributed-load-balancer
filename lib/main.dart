import 'package:distributed/app/bindings/home_binding.dart';
import 'package:distributed/app/views/home_view.dart';
import 'package:distributed/app2/bindings/app_binding.dart';
import 'package:distributed/app2/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      initialBinding: AppBinding(),

      home: const HomeView2(),
    );
    
  }
}