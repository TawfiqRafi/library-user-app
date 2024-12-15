import 'package:flutter/material.dart';
import 'package:library_user_app/common/custom_app_bar.dart';

class CurrentBookScreen extends StatefulWidget {
  const CurrentBookScreen({super.key});

  @override
  State<CurrentBookScreen> createState() => _CurrentBookScreenState();
}

class _CurrentBookScreenState extends State<CurrentBookScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(title: 'Current Book', backButton: false),
      body: Center(
        child: Text('Current Book Screen'),
      )
    );
  }
}
