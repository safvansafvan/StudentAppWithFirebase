import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .logout(context);
              },
              icon: const Icon(Icons.logout))),
    );
  }
}
