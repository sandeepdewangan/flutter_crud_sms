import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_flutter/controllers/student_controller.dart';
import 'package:sms_flutter/views/student_list_view.dart';

import '../models/student.dart';

class StudentAddView extends StatelessWidget {
  static const routeName = '/add_student';
  var studentController = StudentController.find;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = "";
  String _college = "";
  String _optedFor = "";
  double _price = 0;
  Student student = Student();
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      student = ModalRoute.of(context)!.settings.arguments as Student;
      isUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Student"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          //padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(15.0),
          child: studentController.isPageLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    TextFormField(
                      initialValue: student.name ?? '',
                      decoration: InputDecoration(
                        labelText: "Student name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Student name cant be empty";
                        }
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: student.college ?? '',
                      decoration: InputDecoration(
                        labelText: "Student college name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "College name cant be empty";
                        }
                      },
                      onSaved: (value) {
                        _college = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: student.optedFor ?? '',
                      decoration: InputDecoration(
                        labelText: "Opted for",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Opted for cant be null";
                        }
                      },
                      onSaved: (value) {
                        _optedFor = value!;
                      },
                    ),
                    TextFormField(
                      initialValue:
                          student.price != null ? student.price.toString() : '',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Price",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Price cant be null";
                        }
                      },
                      onSaved: (value) {
                        _price = double.parse(value!);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (isUpdate) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await studentController.updateStudent((Student(
                                id: student.id,
                                name: _name,
                                college: _college,
                                optedFor: _optedFor,
                                price: _price)));

                            Navigator.pop(context);
                            return;
                          }
                        }
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await studentController.addStudent(Student(
                              name: _name,
                              college: _college,
                              optedFor: _optedFor,
                              price: _price));

                          Navigator.pop(context);
                        }
                      },
                      child: isUpdate
                          ? Text("Update Student")
                          : Text("Add Student"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
