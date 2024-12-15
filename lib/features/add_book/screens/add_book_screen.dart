import 'package:flutter/material.dart';
import 'package:library_user_app/common/custom_app_bar.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Book', backButton: false),
      body: Center(
        child: Text('Add Book Screen'),
      )
    );
  }

}