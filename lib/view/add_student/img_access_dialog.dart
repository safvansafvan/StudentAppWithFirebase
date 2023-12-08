import 'package:flutter/material.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';

Future<void> dialogWidget(context, DbProvider provider) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          "Select image from",
          style: TextStyle(
              fontSize: 20, color: commonClr, fontWeight: FontWeight.w500),
        ),
        content: SizedBox(
          height: 115,
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  await provider.getImageFromCamera();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt, color: commonClr),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  await provider.getImageFromGallery();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo, color: commonClr),
                title: const Text('Gallery'),
              )
            ],
          ),
        ),
      );
    },
  );
}
