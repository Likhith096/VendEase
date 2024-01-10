import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.pink100,
            body: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                    child: SizedBox(
                        height: SizeUtils.height,
                        width: double.maxFinite,
                        child: Stack(alignment: Alignment.topCenter, children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 55.v),
                                  decoration: AppDecoration.fillPrimary
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder64),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Bhupendra Jogi",
                                            style:
                                                theme.textTheme.displaySmall),
                                        SizedBox(height: 101.v),
                                        _buildProfileSection(context),
                                        SizedBox(height: 101.v)
                                      ]))),
                          CustomImageView(
                              imagePath: ImageConstant.img31357151,
                              height: 144.v,
                              width: 140.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 75.v)),
                          CustomImageView(
                              imagePath: ImageConstant
                                  .imgVendeaselogoRemovebgPreview88x131,
                              height: 88.v,
                              width: 131.h,
                              alignment: Alignment.topRight)
                        ]))))));
  }

  /// Section Widget
  Widget _buildProfileSection(BuildContext context) {
    return Column(children: [
      Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 1.v),
          decoration: AppDecoration.fillPrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 22.v),
                Text("My Orders", style: theme.textTheme.headlineLarge)
              ])),
      SizedBox(height: 18.v),
      Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 9.v),
          decoration: AppDecoration.fillPrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 7.v),
                Text("About", style: theme.textTheme.headlineLarge)
              ])),
      SizedBox(height: 17.v),
      Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 12.v),
          decoration: AppDecoration.fillPrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
          child: Text("Contact Us", style: theme.textTheme.headlineLarge)),
      SizedBox(height: 16.v),
      GestureDetector(
          onTap: () {
            onTapSix(context);
          },
          child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.v),
              decoration: AppDecoration.fillPrimary
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 8.v),
                    Text("Logout", style: theme.textTheme.headlineLarge)
                  ])))
    ]);
  }

  /// Navigates to the loginSignupScreen when the action is triggered.
  onTapSix(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginSignupScreen);
  }
}
