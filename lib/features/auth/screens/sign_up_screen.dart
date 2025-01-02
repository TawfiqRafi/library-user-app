import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/common/custom_text_field.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/features/auth/screens/sign_in_screen.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/images.dart';
import 'package:library_user_app/utils/styles.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.07),
                    Image.asset(
                      Images.logo,
                      height: 200,
                    ),
                    // Text(
                    //   AppConstants.appName,
                    //   style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(height: constraints.maxHeight * 0.01),

                    Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),

                    Column(
                      children: [
                        CustomTextField(
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          controller: _nameController,
                          focusNode: _nameFocus,
                          nextFocus: _emailFocus,
                        ),
                        const SizedBox(height: 16.0),

                        CustomTextField(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          controller: _emailController,
                          focusNode: _emailFocus,
                          nextFocus: _passwordFocus,
                          inputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16.0),

                        CustomTextField(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          nextFocus: _confirmPasswordFocus,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16.0),

                        CustomTextField(
                          labelText: 'Confirm Password',
                          hintText: 'Enter your password again',
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocus,
                          inputAction: TextInputAction.done,
                          isPassword: true,
                        ),
                        // const SizedBox(height: 16.0),

                        // CustomTextField(
                        //   labelText: 'Address',
                        //   hintText: 'Enter your address',
                        //   controller: _addressController,
                        //   focusNode: _addressFocus,
                        //   inputAction: TextInputAction.done,
                        // ),
                        const SizedBox(height: 30.0),

                        CustomButton(
                          text: 'Sign Up',
                          isLoading: authController.isLoading,
                          onTap: () {
                            if (_nameController.text.isEmpty) {
                              showCustomSnackBar('Please enter your name');
                            }/* else if (_phoneController.text.isEmpty) {
                              showCustomSnackBar('Please enter your phone number');
                            }else if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(_phoneController.text)) {
                              showCustomSnackBar('Please enter a valid Bangladeshi phone number');
                            }  */else if (_passwordController.text.isEmpty) {
                              showCustomSnackBar('Please enter your password');
                            } else if (_confirmPasswordController.text.isEmpty) {
                              showCustomSnackBar('Please enter your confirm password');
                            } else if (_passwordController.text != _confirmPasswordController.text) {
                              showCustomSnackBar('Password and confirm password do not match');
                            } else if (_emailController.text.isEmpty) {
                              showCustomSnackBar('Please enter your email');
                            }else {
                              authController.register(
                                name: _nameController.text,
                                password: _passwordController.text,
                                confirmPassword: _confirmPasswordController.text,
                                email: _emailController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),

                        TextButton(
                          onPressed: () {
                            Get.to(() => const SignInScreen());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: robotoRegular.copyWith(color: AppColor.primary),
                                ),
                              ],
                            ),
                            style: robotoRegular.copyWith(color: AppColor.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}