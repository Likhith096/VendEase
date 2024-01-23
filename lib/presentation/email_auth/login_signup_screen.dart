// ignore_for_file: prefer_single_quotes

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();

}
class _LoginSignupScreenState extends State<LoginSignupScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    if(name == "")
    {
      log("Please fill The Name");
    }
    else if(email == "")
    {
      log("Please fill The Email ID");
    }
    else if(password == "")
    {
      log("Please fill The Password");
    }
    else if(email == "")
    {
      log("Please fill The Email ID");
    }
    else
    {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password);
      log("User Created");
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor:
                theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
            body: SizedBox(
                height: SizeUtils.height,
                width: double.maxFinite,
                child: Stack(alignment: Alignment.topRight, children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 37.h, vertical: 195.v),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgGroup73),
                                  fit: BoxFit.cover)),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Spacer(),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 27.h),
                                        child: Text("Welcome!",
                                            style: CustomTextStyles
                                                .displayMediumBlack))),
                                  SizedBox(height: 22.v),
                    // Name Input
                    SizedBox(
                      height: 75.v,
                      width: 306.h,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // Do something if needed
                              },
                              child: Container(
                                height: 64.v,
                                width: 306.h,
                                decoration: BoxDecoration(
                                  color: appTheme.pink100,
                                  borderRadius: BorderRadius.circular(32.h),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 73.h),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.v),
                    // Email Input
                    SizedBox(
                      height: 75.v,
                      width: 306.h,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // Do something if needed
                              },
                              child: Container(
                                height: 64.v,
                                width: 306.h,
                                decoration: BoxDecoration(
                                  color: appTheme.pink100,
                                  borderRadius: BorderRadius.circular(32.h),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 73.h),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.v),
                    // Password Input
                    SizedBox(
                      height: 75.v,
                      width: 306.h,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // Do something if needed
                              },
                              child: Container(
                                height: 64.v,
                                width: 306.h,
                                decoration: BoxDecoration(
                                  color: appTheme.pink100,
                                  borderRadius: BorderRadius.circular(32.h),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 73.h),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.v),
                    // Sign Up Button
                    SizedBox(
                      height: 75.v,
                      width: 306.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: GestureDetector(
                              onTap: () {
                                createAccount();
                              },
                              child: Container(
                                height: 64.v,
                                width: 306.h,
                                decoration: BoxDecoration(
                                  color: appTheme.pink100,
                                  borderRadius: BorderRadius.circular(32.h),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "sign up".toUpperCase(),
                              style: CustomTextStyles.displayMediumOnError,
                            ),
                          ),
                        ],
                      ),
                    ),
                                SizedBox(height: 81.v),
                                SizedBox(
                                    height: 75.v,
                                    width: 306.h,
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                              alignment: Alignment.topCenter,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    onTapView1(context);
                                                  },
                                                  child: Container(
                                                      height: 64.v,
                                                      width: 306.h,
                                                      decoration: BoxDecoration(
                                                          color: appTheme
                                                              .pink100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      32.h))))),
                                          Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  "sign up".toUpperCase(),
                                                  style: CustomTextStyles
                                                      .displayMediumOnError))
                                        ]))
                              ]))),
                  Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                          height: 174.v,
                          width: 162.h,
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgEllipse3,
                                height: 174.v,
                                width: 162.h,
                                alignment: Alignment.center),
                            CustomImageView(
                                imagePath: ImageConstant
                                    .imgVendeaselogoRemovebgPreview131x162,
                                height: 131.v,
                                width: 162.h,
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(top: 18.v))
                          ])))
                ]))));
  }

  // ignore: inference_failure_on_function_return_type
  /// Navigates to the loginScreen when the action is triggered.
  onTapView(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  /// Navigates to the signUpScreen when the action is triggered.
  onTapView1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}
