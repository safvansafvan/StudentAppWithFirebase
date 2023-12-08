import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';
import 'package:studentappfirebase/view/edit_student/edit_student.dart';
import 'package:studentappfirebase/view/widgets/lottie_view.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: commonClr,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kwhite,
            )),
        title: Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: kgrey, blurStyle: BlurStyle.solid, spreadRadius: 1),
          ], color: kwhite, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: TextField(
              controller: provider.searchCtrl,
              onChanged: (value) async {
                await provider.searchStudent(provider.searchCtrl.text);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      provider.searchCtrl.clear();
                    },
                    icon: const Icon(Icons.close)),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<DbProvider>(
        builder: (context, value, _) {
          if (value.stillSearchUser.isEmpty) {
            return const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieView(
                    path: 'assets/animations/empty.json',
                    height: 150,
                    width: 150),
                Text('Tap + Add one')
              ],
            ));
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final student = value.stillSearchUser[index];
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
                          onPressed: (context) async {
                            await value.deleteStudent(index);
                            showMsgToast(msg: 'Deleted', bg: commonClr);
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
                                backgroundImage:
                                    FileImage(File(student.photo!)),
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
                  itemCount: value.stillSearchUser.length),
            );
          }
        },
      ),
    );
  }
}
