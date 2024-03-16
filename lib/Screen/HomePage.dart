import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_hub/Screen/DailyTAsk.dart';
class MyHomePage extends GetView {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Hub"),
      ),
     drawer: Drawer(
       child: Column(
         children: [
           InkWell(onTap:()=> Get.to(DailyTasksPage()),child: Text("Home")),
           Text("Home"),
           Text("Home"),
           Text("Home"),
         ],
       ),
     ),
     body: Container(),
    );
  }
}
