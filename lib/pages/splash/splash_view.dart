import 'package:flutter/material.dart';
import 'package:instrive_chat/app/app_routes.dart';

class SpalshView extends StatelessWidget {
  const SpalshView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()=>Navigator.of(context).pushNamed(Routes.serverPage),
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Text("Let's Chat !"),
          ),
        ),
      ),
    );
  }
}