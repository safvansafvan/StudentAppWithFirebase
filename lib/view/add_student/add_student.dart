import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';
import 'package:studentappfirebase/view/widgets/text_form_view.dart';

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
          CircleAvatar(
            backgroundColor: commonClr,
            radius: 50,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: kwhite,
                )),
          ),
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
                onPressed: () async {},
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
}
