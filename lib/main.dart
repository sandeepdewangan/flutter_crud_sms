import 'package:flutter/material.dart';
import 'package:sms_flutter/controllers/student_controller.dart';
import 'package:sms_flutter/views/student_add_view.dart';
import '/views/student_list_view.dart';
import 'package:get/get.dart';

void main() {
  // register controller
  Get.put(StudentController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS - CPI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: StudentListView.routeName,
      routes: {
        StudentListView.routeName: (ctx) => StudentListView(),
        StudentAddView.routeName: (ctx) => StudentAddView(),
      },
    );
  }
}
