import 'package:flutter/material.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/common/custom_text_field.dart';
import 'package:library_user_app/utils/dimensions.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _authorFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Book', backButton: false),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
              child: Column(spacing: Dimensions.paddingSizeTwenty, children: [

                CustomTextField(
                  controller: _titleController,
                  focusNode: _titleFocusNode,
                  nextFocus: _authorFocusNode,
                  hintText: 'Title',
                ),

                CustomTextField(
                  controller: _authorController,
                  focusNode: _authorFocusNode,
                  hintText: 'Author',
                ),


              ]),
            ),
          ),


          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeThirty),
            child: CustomButton(
              text: 'Add Book',
              onTap: () {

              },
            ),
          ),

        ],
      ),
    );
  }

}