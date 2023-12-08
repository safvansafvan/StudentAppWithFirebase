import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentappfirebase/model/student_model.dart';

class DbProvider extends ChangeNotifier {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController rollNumCtrl = TextEditingController();

  List<StudentModel> studentList = [];
  List<StudentModel> stillSearchUser = [];

  Future<void> addStudent(values) async {
    final studentsDB = await Hive.openBox<StudentModel>('students_db');
    await studentsDB.add(values);
    studentList.add(values);
    getAllStudents();
    notifyListeners();
  }

  Future<void> getAllStudents() async {
    final studentsDB = await Hive.openBox<StudentModel>('students_db');
    studentList.clear();
    studentList.addAll(studentsDB.values);
    stillSearchUser = studentList;
    notifyListeners();
  }

  Future<void> editdetails(int index, StudentModel student) async {
    final studentDB = await Hive.openBox<StudentModel>('students_db');
    studentDB.putAt(index, student);
    getAllStudents();
    notifyListeners();
  }

  Future<void> deletest(int index) async {
    final studentDB = await Hive.openBox<StudentModel>('students_db');
    studentDB.deleteAt(index);
    getAllStudents();
    notifyListeners();
  }

  Future<void> searchStudent(String text) async {
    List<StudentModel> result = [];
    if (text.isEmpty) {
      result = studentList;
      notifyListeners();
    } else {
      result = studentList
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    stillSearchUser = result;
    notifyListeners();
  }
}
