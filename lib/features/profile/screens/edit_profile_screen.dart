import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/common/custom_text_field.dart';
import 'package:library_user_app/features/profile/controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _nameController.text = Get.find<ProfileController>().profileModel?.content?.firstName ?? '';
    _phoneController.text = Get.find<ProfileController>().profileModel?.content?.phone ?? '';
    _addressController.text = Get.find<ProfileController>().profileModel?.content?.address ?? '';


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
     /* body: GetBuilder<ProfileController>(
        builder: (profileController) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [

                      Center(child: Stack(children: [

                        ClipOval(child: profileController.pickedFile != null ? GetPlatform.isWeb ? Image.network(
                            profileController.pickedFile!.path, width: 80, height: 80, fit: BoxFit.cover) : Image.file(
                            File(profileController.pickedFile!.path), width: 80, height: 80, fit: BoxFit.cover) : CustomNetworkImage(
                          image: '${profileController.profileModel!.content!.image}',
                          height: 80, width: 80, fit: BoxFit.cover,
                        )),

                        Positioned(
                          bottom: 0, right: 0, top: 0, left: 0,
                          child: InkWell(
                            onTap: () => profileController.pickImage(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
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
                      const SizedBox(height: 20),

                      CustomTextField(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        controller: _nameController,
                        focusNode: _nameFocus,
                        nextFocus: _phoneFocus,
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        labelText: 'Phone',
                        hintText: 'Enter your phone',
                        controller: _phoneController,
                        focusNode: _phoneFocus,
                        nextFocus: _passwordFocus,
                        inputType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        nextFocus: _confirmPasswordFocus,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        labelText: 'Confirm Password',
                        hintText: 'Enter your password again',
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        nextFocus: _addressFocus,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        labelText: 'Address',
                        hintText: 'Enter your address',
                        controller: _addressController,
                        focusNode: _addressFocus,
                        inputAction: TextInputAction.done,
                      ),

                    ]),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomButton(
                  isLoading: profileController.isLoading,
                  text: 'Save',
                  onTap: () {
                    if (_nameController.text.isEmpty) {
                      showCustomSnackBar('Enter your name');
                    }else if (_phoneController.text.isEmpty) {
                      showCustomSnackBar('Enter your phone number');
                    } else if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(_phoneController.text)) {
                      showCustomSnackBar('Please enter a valid Bangladeshi phone number');
                    } else if (_passwordController.text.isEmpty) {
                      showCustomSnackBar('Enter your password');
                    }else if (_confirmPasswordController.text.isEmpty) {
                      showCustomSnackBar('Enter your confirm password');
                    }else if (_passwordController.text != _confirmPasswordController.text) {
                      showCustomSnackBar('Password does not match');
                    }else if (_addressController.text.isEmpty) {
                      showCustomSnackBar('Enter your address');
                    }else {
                      profileController.updateUserInfo(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                        address: _addressController.text,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      ),*/
    );
  }
}
