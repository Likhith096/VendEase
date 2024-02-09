import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart'; // Ensure this import is correct
import 'package:vendeaze/widgets/custom_elevated_button.dart'; // Ensure this import is correct
import 'package:vendeaze/widgets/custom_text_form_field.dart'; // Ensure this import is correct
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the screen is disposed
    nameFieldController.dispose();
    emailFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
    void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential = await _auth.signInWithProvider(_googleAuthProvider);
      if (userCredential.user != null) {
        log("User's name: ${userCredential.user!.displayName}");
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': userCredential.user!.displayName,
          'email': userCredential.user!.email,
          // Add more fields as needed
        });
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      }
    } catch (error) {
      print(error);
    }
}


Future<void> createAccount() async {
  String email = emailFieldController.text.trim();
  String password = passwordFieldController.text.trim();
  String name = nameFieldController.text.trim();

  // Regular expression for validating email
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  // Regular expression for validating password
  RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$',
  );

  if (name.isEmpty) {
    log("Please fill in the name");
  } else if (email.isEmpty || !emailRegExp.hasMatch(email)) {
    log("Please enter a valid email ID");
  } else if (password.isEmpty || !passwordRegExp.hasMatch(password)) {
    log("Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character");
  } else {
    try {
      // Removed the unused variable 'userCredential'
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      log("User Created");
      if(userCredential.user != null)
      {
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': name,
          'email': email,
          'password':password,
        });

        Navigator.pushNamed(context, AppRoutes.loginScreen);
      }

      // If you want to use the created user information, you can do it here.
      // For example:
      // User? user = FirebaseAuth.instance.currentUser;
      // Update the user profile or navigate to another screen

    } on FirebaseAuthException catch (e) {
      log("Failed to create account: ${e.message}");
    }
  }
}
@override
Widget build(BuildContext context) {
  return SafeArea(
    child: GestureDetector(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
        body: SingleChildScrollView(
          // Set keyboardDismissBehavior to onDrag
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            // key: _formKey,
            child: SizedBox(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 835.v,
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgApp21,
                            height: 835.v,
                            width: 390.h,
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.h, bottom: 63.v),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name", style: theme.textTheme.displayMedium),
                                  _buildNameField(context),
                                  Text("Email", style: theme.textTheme.displayMedium),
                                  _buildEmailField(context),
                                  SizedBox(height: 2.v),
                                  Text("Password", style: theme.textTheme.displayMedium),
                                  _buildPasswordField(context),
                                  SizedBox(height: 43.v),
                                  _buildSignUpButton(context),
                                  SizedBox(height: 26.v),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("or", style: theme.textTheme.headlineSmall),
                                  ),
                                  SizedBox(height: 14.v),
                                  _buildSignUpWithGoogleButton(context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse31,
                    height: 174.v,
                    width: 390.h,
                    alignment: Alignment.topCenter,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgVendeaselogoRemovebgPreview164x255,
                    height: 164.v,
                    width: 255.h,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 26.v),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

  /// Section Widget
  Widget _buildNameField(BuildContext context) {
    return CustomTextFormField(
        controller: nameFieldController, hintText: "Enter Name");
  }

  /// Section Widget
  Widget _buildEmailField(BuildContext context) {
    return CustomTextFormField(
        controller: emailFieldController,
        hintText: "Enter Email",
        textInputType: TextInputType.emailAddress);
  }

  /// Section Widget
  Widget _buildPasswordField(BuildContext context) {
    return CustomTextFormField(
        controller: passwordFieldController,
        hintText: "Enter Password",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        obscureText: true);
  }

  /// Section Widget
  Widget _buildSignUpButton(BuildContext context) {
    return CustomElevatedButton(
        width: 216.h,
        text: "Sign Up".toUpperCase(),
        buttonTextStyle: CustomTextStyles.headlineLargeLivvicOnError,
        onPressed: () {
          createAccount();
        },
        alignment: Alignment.center);
  }

  /// Section Widget
  Widget _buildSignUpWithGoogleButton(BuildContext context) {
    return CustomElevatedButton(
        height: 42.v,
        text: "Sign up with google".toUpperCase(),
        margin: EdgeInsets.only(left: 37.h, right: 36.h),
        leftIcon: Container(
            margin: EdgeInsets.only(right: 9.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgDevicongoogle,
                height: 32.v,
                width: 37.h)),
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: theme.textTheme.titleMedium!,
        onPressed: () {
          _handleGoogleSignIn();
        },
        alignment: Alignment.center);
  }

  /// Navigates to the frameElevenScreen when the action is triggered.
  onTapSignUpButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frameElevenScreen);
  }
}