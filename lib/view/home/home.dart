import 'package:flutter/material.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/view/list_student/list_student.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authClr,
      appBar: AppBar(
        backgroundColor: commonClr,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: kwhite,
            )),

        title: Text(
          'Studnet List',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: kwhite),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'searchView');
              },
              icon: Icon(Icons.search, color: kwhite))
        ],
        // title: Container(
        //   margin: const EdgeInsets.symmetric(vertical: 10),
        //   decoration: BoxDecoration(
        //       color: kwhite, borderRadius: BorderRadius.circular(10)),
        //   child: Center(
        //     child: TextField(
        //       // controller: provider.search,
        //       onChanged: (value) {},
        //       decoration: InputDecoration(
        //         hintText: 'Search...',
        //         prefixIcon: const Icon(Icons.search),
        //         suffixIcon:
        //             IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        //         focusedBorder: InputBorder.none,
        //         enabledBorder: InputBorder.none,
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: const StudentListView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 45,
        child: FloatingActionButton.extended(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          elevation: 5,
          icon: Icon(Icons.add, color: kwhite),
          backgroundColor: commonClr,
          onPressed: () {
            Navigator.pushNamed(context, 'addView');
          },
          label: Text(
            ' Add Student',
            style: TextStyle(color: kwhite),
          ),
        ),
      ),
    );
  }
}
