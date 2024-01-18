import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';
import 'package:vendeaze/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController nameFieldController = TextEditingController();

  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();

  //GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: GestureDetector(
      onTap: () {
        // Close keyboard when tapping outside of a text field
        FocusScopeNode focusStatus = FocusScope.of(context);
        if (!focusStatus.hasPrimaryFocus) {
          focusStatus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
        resizeToAvoidBottomInset: false,
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
          onTapSignUpButton(context);
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
          onTapSignUpButton(context);
        },
        alignment: Alignment.center);
  }

  /// Navigates to the frameElevenScreen when the action is triggered.
  onTapSignUpButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frameElevenScreen);
  }
}
