import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';
import 'package:studentappfirebase/model/student_model.dart';
import 'package:studentappfirebase/view/add_student/img_access_dialog.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';
import 'package:studentappfirebase/view/widgets/text_form_view.dart';

class EditStudentView extends StatelessWidget {
  const EditStudentView(
      {super.key, required this.stModel, required this.index});
  final StudentModel stModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<DbProvider>(builder: (context, value, _) {
          value.nameEditCtrl = TextEditingController(text: stModel.name);
          value.ageEditCtrl = TextEditingController(text: stModel.name);
          value.rollEditCtrl = TextEditingController(text: stModel.name);
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: const Text(
                  'Update Student Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: commonClr),
                ),
              ),
              Consumer<DbProvider>(builder: (context, provider, _) {
                return CircleAvatar(
                  backgroundColor: commonClr,
                  backgroundImage:
                      FileImage(File(value.fileImg?.path ?? stModel.photo)),
                  radius: 60,
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
                  controller: value.nameEditCtrl,
                  hintText: "Name",
                  isNum: false),
              TextFormView(
                  controller: value.ageEditCtrl, hintText: "Age", isNum: true),
              TextFormView(
                  controller: value.rollEditCtrl,
                  hintText: "Roll No",
                  isNum: true),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: ElevatedButton(
                    onPressed: () async {
                      await handleEditStudent(context, index);
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
          );
        }),
      ),
    );
  }

  Future<void> handleEditStudent(context, index) async {
    final db = Provider.of<DbProvider>(context, listen: false);
    final name = db.nameEditCtrl.text.trim();
    final age = db.ageEditCtrl.text.trim();
    final rollNo = db.rollEditCtrl.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        rollNo.isEmpty ||
        db.fileImg!.path.isEmpty) {
      return showMsgToast(msg: 'Empty Field');
    } else {
      final student = StudentModel(
        name: name,
        age: age,
        rollnumber: rollNo,
        photo: db.fileImg!.path,
      );
      await db.editStudents(index, student);
      db.clearController();
      showMsgToast(msg: '$name is updated', bg: commonClr);
    }
  }
}
