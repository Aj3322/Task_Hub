
import 'package:get/get.dart';

import '../Model/Task.dart';
import 'TaskController.dart';
class HomeController extends GetxController{
  RxList<Task> completedTask = <Task>[].obs;
  RxList<Task> totalTask = <Task>[].obs;
  RxList<Task> missedTask = <Task>[].obs;
  RxList<Task> pendingTask =<Task>[].obs;



  DateTime today = DateTime.now();
// DateTime startDate = today.startOfDay;
// DateTime endDate = today.endOfDay;

  // Future<void> fetchTasks() async {
  //   try {
  //     final collectionRef = FirebaseFirestore.instance.collection('tasks');
  //     final snapshot = await collectionRef.get();
  //
  //     final tasks = snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();
  //     completedTask.assignAll(tasks.where((task) => task.completed));
  //     totalTask.assignAll(tasks); // Assign all tasks to totalTask
  //     missedTask.assignAll(tasks.where((task) => task.missed));
  //     pendingTask.assignAll(tasks.where((task) => !task.completed && !task.missed));
  //     update();
  //   } catch (error) {
  //     print('Error fetching tasks: $error');
  //     // Handle error appropriately
  //   }
  // }

  @override
  void onInit() {
    // fetchTasks();
    super.onInit();
  }
}

extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}
