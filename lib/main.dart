import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/controller/providers/db_provider.dart';
import 'package:studentappfirebase/controller/providers/internet_provider.dart';
import 'package:studentappfirebase/view/add_student/add_student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider provider = AuthProvider();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
        ChangeNotifierProvider(create: (context) => DbProvider())
      ],
      child: MaterialApp(
        title: 'studentapp',
        theme: ThemeData(
          fontFamily: GoogleFonts.openSans().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: provider.handleScreens(context),
        routes: {
          'addView': (context) => const AddStudentView(),
        },
      ),
    );
  }
}
