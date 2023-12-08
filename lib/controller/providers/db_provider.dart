import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentappfirebase/model/student_model.dart';

class DbProvider extends ChangeNotifier {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController rollNumCtrl = TextEditingController();

  TextEditingController searchCtrl = TextEditingController();

  List<StudentModel> studentList = [];
  List<StudentModel> stillSearchUser = [];

  Future<void> addStudent(StudentModel values) async {
    final studentsDB = await Hive.openBox<StudentModel>('st_db');
    await studentsDB.add(values);
    studentList.add(values);
    getAllStudents();
    notifyListeners();
  }

  Future<void> getAllStudents() async {
    final studentsDB = await Hive.openBox<StudentModel>('st_db');
    studentList.clear();
    studentList.addAll(studentsDB.values);
    notifyListeners();
  }

  Future<void> editStudents(int index, StudentModel student) async {
    final studentDB = await Hive.openBox<StudentModel>('st_db');
    studentDB.putAt(index, student);
    getAllStudents();
    notifyListeners();
  }

  Future<void> deleteStudent(int index) async {
    final studentDB = await Hive.openBox<StudentModel>('st_db');
    studentDB.deleteAt(index);
    getAllStudents();
    notifyListeners();
  }

  Future<void> searchStudent(query) async {
    List<StudentModel> result = [];
    if (query.isEmpty) {
      result = studentList;
      notifyListeners();
    } else {
      result = studentList
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .trim()
              .startsWith(query.toLowerCase().trim()))
          .toList();
    }
    stillSearchUser = result;
    notifyListeners();
  }

  void clearController() {
    nameCtrl.clear();
    ageCtrl.clear();
    rollNumCtrl.clear();
    fileImg = null;
  }

  File? fileImg;
  Future<void> getImageFromGallery() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      fileImg = photoTemp;
    }
    notifyListeners();
  }

  Future<void> getImageFromCamera() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      fileImg = photoTemp;
    }
    notifyListeners();
  }
}
