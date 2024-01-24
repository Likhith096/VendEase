import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
              backgroundColor: theme.colorScheme.onPrimaryContainer,
              body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(alignment: Alignment.topRight, children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.h, vertical: 47.v),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgGroup13),
                                  fit: BoxFit.cover)),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                //Spacer(),
                                child:Container(
                                    height: 190.v,
                                    width: 248.h,
                                    margin: EdgeInsets.only(left: 15.h),
                                    child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text("Hey Foodie",
                                                  style: CustomTextStyles
                                                      .londrinaSolidPrimary))
                                        ]))),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.h),
                                    child: Text(
                                        "Let’s vend your favorite snack",
                                        style: CustomTextStyles
                                            .headlineSmallLondrinaSolid)),
                                SizedBox(height: 24.v),
                                CustomElevatedButton(
                                    height: 40.v,
                                    width: 180.h,
                                    text: "Get Started".toUpperCase(),
                                    margin: EdgeInsets.only(left: 15.h),
                                    buttonStyle: CustomButtonStyles.fillPink,
                                    onPressed: () {
                                      onTapGetStarted(context);
                                    }),
                                SizedBox(height: 20.v),
                                CustomImageView(
                                    imagePath: ImageConstant.imgArrow2,
                                    height: 2.v,
                                    width: 16.h,
                                    alignment: Alignment.centerRight)
                              ]))),
                  CustomImageView(
                      imagePath: ImageConstant.imgEllipse1,
                      height: 304.v,
                      width: 272.h,
                      alignment: Alignment.topRight),
                  CustomImageView(
                      imagePath: ImageConstant.imgVendeaselogoRemovebgPreview,
                      height: 278.v,
                      width: 293.h,
                      radius: BorderRadius.circular(30.h),
                      alignment: Alignment.topRight)
                ])))));
  }

  /// Navigates to the loginSignupScreen when the action is triggered.
  onTapGetStarted(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginSignupScreen);
  }
}
