
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_hub/Controller/Binding.dart';
import 'package:task_hub/Screen/DailyTAsk.dart';

import 'Screen/HomePage.dart';
import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  DailyTasksPage(),
      initialBinding: HomeBinding(),
    );
  }
}


