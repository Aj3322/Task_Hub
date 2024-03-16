import 'package:get/get.dart';
import 'package:task_hub/Controller/TaskController.dart';

import 'HomeController.dart';
import 'RoutineController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TaskController());
  }

}