import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';
import 'package:studentappfirebase/view/edit_student/edit_student.dart';
import 'package:studentappfirebase/view/widgets/lottie_view.dart';

class StudentListView extends StatelessWidget {
  const StudentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
      builder: (context, value, _) {
        value.getAllStudents();
        if (value.studentList.isEmpty) {
          return const Center(
              child: LottieView(
                  path: 'assets/animations/empty.json',
                  height: 100,
                  width: 100));
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final student = value.studentList[index];
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudentView(
                                  stModel: student, index: index),
                            ),
                          );
                        },
                        icon: Icons.edit,
                        foregroundColor: Colors.blue,
                        backgroundColor: authClr,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          value.deleteStudent(index);
                        },
                        icon: Icons.delete_outline,
                        foregroundColor: Colors.red,
                        backgroundColor: authClr,
                      )
                    ]),
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      color: kwhite,
                      child: SizedBox(
                        height: 60,
                        child: Center(
                          child: ListTile(
                            onTap: () {},
                            title: Text(student.name.toUpperCase(),
                                style: const TextStyle(fontSize: 15)),
                            leading: CircleAvatar(
                              backgroundImage: FileImage(File(student.photo)),
                              radius: 25,
                            ),
                            trailing: IconButton(
                                tooltip: 'Drag left',
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: commonClr,
                                )),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: value.studentList.length),
          );
        }
      },
    );
  }
}
