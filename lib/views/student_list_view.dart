import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_flutter/controllers/student_controller.dart';
import 'package:sms_flutter/views/student_add_view.dart';

class StudentListView extends StatefulWidget {
  static const routeName = '/student_list';

  @override
  _StudentListViewState createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  var studentController = StudentController.find;
  var isFirst = true;
  String? error;

  @override
  void initState() {
    super.initState();
    print("init called");
    studentController.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SMS - CPI"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, StudentAddView.routeName);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: GetX<StudentController>(
          builder: (controller) {
            if (controller.isPageLoading.value)
              return Center(child: CircularProgressIndicator());
            else
              return ListView.builder(
                itemCount: controller.students.length,
                itemBuilder: (ctx, index) => Card(
                  child: ListTile(
                    title: Text(controller.students[index].name.toString()),
                    subtitle: Container(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Row(
                          children: controller.students[index].optedFor!
                              .split(",")
                              .map((e) => Chip(label: Text(e.toString())))
                              .toList(),
                        ),
                      ),
                    ),
                    // Text(controller.students[index].college.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, StudentAddView.routeName,
                                arguments: controller.students[index]);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.deleteStudent(
                                controller.students[index].id.toString());
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          },
        ));
  }
}
