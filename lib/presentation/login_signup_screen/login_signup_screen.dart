import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

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
                                                    onTapView(context);
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
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 73.h),
                                                  child: Text(
                                                      "Login".toUpperCase(),
                                                      style: CustomTextStyles
                                                          .displayMediumOnError)))
                                        ])),
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

  /// Navigates to the loginScreen when the action is triggered.
  onTapView(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  /// Navigates to the signUpScreen when the action is triggered.
  onTapView1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}
