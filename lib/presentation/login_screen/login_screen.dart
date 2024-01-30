import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';
import 'package:vendeaze/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

   void login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email == "")
    {
      log("Please Fill the email ID");
    }
    else if(password == "")
    {
      log("Please Fill the password");
    }
    else
    {
      try {
          // Removed the unused variable 'userCredential'
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
          log("Login Successful");
          if(userCredential.user != null)
          {
            Navigator.pushNamed(context, AppRoutes.homeScreen);
          }
        } on FirebaseAuthException catch (e) {
          log("Failed to create account: ${e.message}");
        }
    }
   }

  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: GestureDetector(
        onTap: () {
          // Close keyboard when tapping outside of a text field
          FocusScopeNode focusStatus = FocusScope.of(context);
          if(!focusStatus.hasPrimaryFocus){
            focusStatus.unfocus();
          }
        },
    child: Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            child: SizedBox(
              height: SizeUtils.height,
              width: double.maxFinite,
              //key: _formKey,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 104.v),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageConstant.imgGroup73),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: Text("Email", style: CustomTextStyles.displayMedium50),
                          ),
                          SizedBox(height: 9.v),
                          Padding(
                            padding: EdgeInsets.only(right: 12.h),
                            child: CustomTextFormField(
                              controller: emailController,
                              hintText: "enter Email",
                              textInputType: TextInputType.emailAddress,
                              focusNode: emailFocusNode,
                            ),
                          ),
                          SizedBox(height: 58.v),
                          _buildPasswordStack(context),
                          SizedBox(height: 54.v),
                          CustomElevatedButton(
                            width: 216.h,
                            text: "LOGIN".toUpperCase(),
                            margin: EdgeInsets.only(left: 62.h),
                            buttonTextStyle: CustomTextStyles.headlineLargeLivvicOnErrorBold,
                            onPressed: () {
                              //login(context);
                              onTapLOGIN(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse3174x390,
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



  Widget _buildPasswordStack(BuildContext context) {
    return Container(
      height: 128.v,
      width: 340.h,
      margin: EdgeInsets.only(left: 6.h),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomTextFormField(
            width: 340.h,
            controller: passwordController,
            hintText: "enter Password",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            alignment: Alignment.bottomCenter,
            obscureText: true,
            focusNode: passwordFocusNode,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text("Password", style: CustomTextStyles.displayMedium50),
            ),
          ),
        ],
      ),
    );
  }

  void onTapLOGIN(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes when the widget is removed from the widget tree
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
}
}