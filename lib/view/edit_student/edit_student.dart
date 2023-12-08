import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';
import 'package:studentappfirebase/model/student_model.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';
import 'package:studentappfirebase/view/widgets/text_form_view.dart';

// ignore: must_be_immutable
class EditStudentView extends StatelessWidget {
  EditStudentView({super.key, required this.stModel, required this.index});
  final StudentModel stModel;
  final int index;

  TextEditingController nameEditCtrl = TextEditingController();
  TextEditingController ageEditCtrl = TextEditingController();
  TextEditingController rollEditCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameEditCtrl.text = stModel.name;
    ageEditCtrl.text = stModel.age;
    rollEditCtrl.text = stModel.rollnumber;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<DbProvider>(builder: (context, value, _) {
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
              commonHeight,
              Form(
                  child: Column(
                children: [
                  TextFormView(
                      controller: nameEditCtrl, hintText: "Name", isNum: false),
                  TextFormView(
                      controller: ageEditCtrl, hintText: "Age", isNum: true),
                  TextFormView(
                      controller: rollEditCtrl,
                      hintText: "Roll No",
                      isNum: true),
                ],
              )),
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
    final name = nameEditCtrl.text.trim();
    final age = ageEditCtrl.text.trim();
    final rollNo = rollEditCtrl.text.trim();

    if (name.isEmpty || age.isEmpty || rollNo.isEmpty) {
      return showMsgToast(msg: 'Empty Field');
    } else {
      final student = StudentModel(
        name: name,
        age: age,
        rollnumber: rollNo,
      );
      await db.editStudents(index, student);
      db.clearController();
      showMsgToast(msg: '$name is updated', bg: commonClr);
    }
  }
}
