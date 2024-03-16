import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_hub/Controller/TaskController.dart';

import '../Controller/HomeController.dart';
import '../Utils/text.dart';


class DailyTasksPage extends GetView<TaskController> {
  DailyTasksPage({Key? key}) : super(key: key);

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController priority = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController medicationScheduleController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(95, 65, 165, 1),
        title: const Text('Task Hub'),
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Today Tasks',
              style: textStyleWhite(FontWeight.w400, 18.0),
            ),
            SizedBox(
              height: 20,
            ),
            // row('8:00', 'Donepezil', context),
            // row('9:15', 'Read', context),
            // row('9:55', 'Go to sleep', context)
            Obx(() => Expanded(
              child: ListView.builder(
                itemCount: controller.totalTask.length,
                itemBuilder: (context, index) {
                  return row(
                      controller.totalTask[index].schedule,
                      controller.totalTask[index].title,
                      context,
                      controller.totalTask[index].completed,
                      controller.totalTask[index]);
                },
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
              // Optional for handling long forms
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(20),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Title'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                            controller: title,
                          ),
                          TextFormField(
                            decoration:
                            const InputDecoration(labelText: 'Description'),
                            controller: description,
                          ),
                          TextFormField(
                            decoration:
                            const InputDecoration(labelText: 'Set Priority'),
                            controller: priority,
                          ),
                          TextField(
                            controller: medicationScheduleController,
                            onTap: () async {
                              // Show time picker dialog
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: Get.context!,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                // Format the time as needed
                                String formattedTime = pickedTime.format(Get.context!);
                                // Or:
                                // String formattedTime = '${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}'; // Custom formatting

                                medicationScheduleController.text = formattedTime;
                              }
                            },
                            decoration: const InputDecoration(labelText: 'Schedule'),
                          ),
                        ],
                      ),
                      // SizedBox(height: 100,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // ElevatedButton.icon(
                            //   icon: Icon(Icons.timer_sharp),
                            //   onPressed: () {},
                            //   label: Text("Set Time"),
                            // ),
                            ElevatedButton(
                              onPressed: () async {
                                print("clicked");
                                controller
                                    .insertTask(Task(
                                    title: title.text,
                                    schedule: medicationScheduleController.text,
                                    createdAt: DateTime.now(),
                                    description: description.text,
                                    priority: priority.text))
                                    .then((value) =>controller.fetchTasks());
                                Navigator.pop(context); // Close bottom sheet
                              },
                              child: Text('Add Task'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add Task'),
      ),
    );
  }

  Widget row(time, title, BuildContext context, bool comp, Task task) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(time, style: textStyleWhite(FontWeight.w400, 16.0)),
          SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: ()async {
                final confirmed = await Get.dialog<bool>(
                  AlertDialog(
                    title: Text(task.title),
                    content: Text(task.description),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false), // Cancel
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back(result: true); // Confirm

                          task.completed=true;

                          controller.updateTask(task.id);
                          controller.fetchTasks();
                        },
                        child:Text(task.completed?"UnMark":'Mark as Completed'),
                      ),

                    ],
                  ),
                );
              },
              onLongPress: () async {
                final confirmed = await Get.dialog<bool>(
                  AlertDialog(
                    title: Text('Update Task Status'),
                    content: Text(
                        'Are you sure you want to mark this task as completed?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false), // Cancel
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back(result: true); // Confirm
                          task.completed=true;
                          controller.updateTask(task.id);
                          controller.fetchTasks();
                        },
                        child: Text(task.completed?"UnMark":'Mark as Completed'),
                      ),

                    ],
                  ),
                );

                controller.updateTask(task.id);
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // color: comp ? Colors.green : Colors.red,
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: comp ? Colors.green : Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(title),
                      ],
                    ),
                    SizedBox(width: 78),
                    IconButton(onPressed: (){controller.deleteTask(task.id);}, icon: Icon(Icons.delete,color: Theme.of(context).primaryColor))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
