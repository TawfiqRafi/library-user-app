import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/common/custom_text_field.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/utils/app_color.dart';
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
      appBar: const CustomAppBar(title: 'Add Book'),
      body: GetBuilder<BookController>(
        builder: (bookController) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
                  child: Column(spacing: Dimensions.paddingSizeTwenty, children: [
          
                    Center(child: Stack(children: [
          
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusTen),
                          child: bookController.pickedBookImage != null ? Image.file(
                          File(bookController.pickedBookImage!.path), height: 150, width: 200, fit: BoxFit.cover) : const CustomNetworkImage(
                        image: '',
                        height: 150, width: 200, fit: BoxFit.cover,
                      )),
          
                      Positioned(
                        bottom: 30, right: 30, top: 30, left: 30,
                        child: InkWell(
                          onTap: () => bookController.pickImage(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3), shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
          
                    ])),
                    //const SizedBox(height: 20),
          
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
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
                ),
                padding: const EdgeInsets.all(Dimensions.paddingSizeTwenty),
                child: CustomButton(
                  isLoading: bookController.isLoading,
                  text: 'Add Book',
                  onTap: () {
                    if(_titleController.text.isEmpty){
                      showCustomSnackBar('Please enter book title');
                    }else if(_authorController.text.isEmpty){
                      showCustomSnackBar('Please enter book author');
                    }else if(bookController.pickedBookImage == null){
                      showCustomSnackBar('Please select book image');
                    }else{
                      bookController.addBook(title: _titleController.text, author: _authorController.text);
                    }
                  },
                ),
              ),
          
            ],
          );
        }
      ),
    );
  }

}