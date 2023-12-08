import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';
import 'package:studentappfirebase/model/student_model.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';
import 'package:studentappfirebase/view/widgets/text_form_view.dart';
import 'img_access_dialog.dart';

class AddStudentView extends StatelessWidget {
  const AddStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context, listen: false);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 50),
            child: const Text(
              'Enter User Details',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: commonClr),
            ),
          ),
          Consumer<DbProvider>(builder: (context, provider, _) {
            return CircleAvatar(
              backgroundColor: commonClr,
              backgroundImage: provider.fileImg == null
                  ? null
                  : FileImage(File(provider.fileImg!.path)),
              radius: 50,
              child: IconButton(
                onPressed: () async {
                  await dialogWidget(context, provider);
                },
                icon: Icon(
                  provider.fileImg == null
                      ? Icons.add_photo_alternate
                      : Icons.restore,
                  size: 40,
                  color: kwhite,
                ),
              ),
            );
          }),
          commonHeight,
          TextFormView(
              controller: dbProvider.nameCtrl, hintText: 'Name', isNum: false),
          TextFormView(
              controller: dbProvider.ageCtrl, hintText: 'Age', isNum: true),
          TextFormView(
              controller: dbProvider.rollNumCtrl,
              hintText: 'Roll',
              isNum: true),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: ElevatedButton(
                onPressed: () async {
                  await handleAddStudent(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: commonClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text(
                  'Add Student',
                  style: TextStyle(color: kwhite),
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: commonClr,
        shape: const CircleBorder(),
        child: Icon(Icons.people, color: kwhite),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Future<void> handleAddStudent(context) async {
    final db = Provider.of<DbProvider>(context, listen: false);
    final name = db.nameCtrl.text.trim();
    final age = db.ageCtrl.text.trim();
    final rollNo = db.rollNumCtrl.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        rollNo.isEmpty ||
        db.fileImg!.path.isEmpty) {
      showMsgToast(msg: 'Empty Field');
    } else {
      final student = StudentModel(
        name: name,
        age: age,
        rollnumber: rollNo,
        photo: db.fileImg!.path,
      );
      await db.addStudent(student);
      showMsgToast(msg: '$name is added}');
    }
  }
}
