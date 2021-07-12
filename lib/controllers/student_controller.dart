import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class StudentController extends GetxController {
  // to listen
  var students = <Student>[].obs;
  // Url to firestore db
  var url =
      Uri.parse("https://test-fe651-default-rtdb.firebaseio.com/students.json");

  // find controller
  static StudentController get find => Get.find<StudentController>();
  // page loading indicator
  var isPageLoading = false.obs;

  Future<void> addStudent(Student student) async {
    try {
      var res = await http.post(url,
          body: json.encode({
            'name': student.name,
            'college': student.college,
            'optedFor': student.optedFor,
            'price': student.price,
          }));
      fetchStudents();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchStudents() async {
    isPageLoading(true);
    try {
      var res = await http.get(url);
      var studentDecodedData = json.decode(res.body) as Map<String, dynamic>;
      var loadedStudents = <Student>[];
      studentDecodedData.forEach((studentId, studentData) {
        loadedStudents.add(Student(
            id: studentId,
            name: studentData['name'],
            college: studentData['college'],
            price: studentData['price'],
            optedFor: studentData['optedFor']));
      });
      // clear the students list first
      students.clear();
      students.value = loadedStudents;
    } catch (error) {
      print(error);
      throw ("Error has been occured - $error");
    } finally {
      // set page loading to false
      isPageLoading(false);
    }
  }

  Future<void> updateStudent(Student student) async {
    var updateUrl = Uri.parse(
        "https://test-fe651-default-rtdb.firebaseio.com/students/${student.id}.json");
    try {
      var response = await http.patch(
        updateUrl,
        body: json.encode({
          'name': student.name,
          'college': student.college,
          'optedFor': student.optedFor,
          'price': student.price,
        }),
      );
      fetchStudents();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteStudent(String id) async {
    var deteleUrl = Uri.parse(
        "https://test-fe651-default-rtdb.firebaseio.com/students/$id.json");
    try {
      await http.delete(deteleUrl);
      students.removeWhere((stu) => stu.id == id);
    } catch (e) {
      print(e);
    }
  }
}
