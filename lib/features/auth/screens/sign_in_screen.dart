import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/common/custom_drop_down_button.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/common/custom_text_field.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/features/auth/screens/sign_up_screen.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/app_constants.dart';
import 'package:library_user_app/utils/images.dart';
import 'package:library_user_app/utils/styles.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
                    SizedBox(height: constraints.maxHeight * 0.05),
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
                      "Sign In",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),

                    Column(
                      children: [
                        CustomTextField(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          controller: _phoneController,
                          focusNode: _phoneFocus,
                          nextFocus: _passwordFocus,
                          inputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16.0),

                        CustomTextField(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          inputType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),

                        const SizedBox(height: 30),

                        CustomButton(
                          text: 'Sign in',
                          isLoading: authController.isLoading,
                          onTap: () {
                            if(_phoneController.text.isEmpty) {
                              showCustomSnackBar('Please enter email');
                            }/*else if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(_phoneController.text)) {
                              showCustomSnackBar('Please enter a valid Bangladeshi phone number');
                            }*/else if(_passwordController.text.isEmpty) {
                              showCustomSnackBar('Please enter password');
                            }else {
                              authController.login(
                                email: _phoneController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 16.0),
                        /*TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: robotoRegular.copyWith(color: AppColor.grey),
                          ),
                        ),*/

                        TextButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Don’t have an account? ",
                              children: [
                                TextSpan(
                                  text: "Sign Up",
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
