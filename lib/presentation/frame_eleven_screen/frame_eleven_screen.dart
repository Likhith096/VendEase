import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';

class FrameElevenScreen extends StatelessWidget {
  const FrameElevenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: 323.h,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildWidgetStack(context),
                      SizedBox(height: 23.v),
                      SizedBox(
                          width: 140.h,
                          child: Text("Sign up success!",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.headlineLargePurple400)),
                      SizedBox(height: 2.v)
                    ])),
            bottomNavigationBar: _buildLoginButton(context)));
  }

  /// Section Widget
  Widget _buildWidgetStack(BuildContext context) {
    return SizedBox(
        height: 117.v,
        width: 323.h,
        child: Stack(alignment: Alignment.center, children: [
          CustomImageView(
              imagePath: ImageConstant.imgEllipse5,
              height: 116.v,
              width: 323.h,
              alignment: Alignment.center),
          CustomImageView(
              imagePath: ImageConstant.imgVendeaselogoRemovebgPreview117x208,
              height: 117.v,
              width: 208.h,
              alignment: Alignment.center)
        ]));
  }

  /// Section Widget
  Widget _buildLoginButton(BuildContext context) {
    return CustomElevatedButton(
        height: 46.v,
        width: 139.h,
        text: "LOGIN".toUpperCase(),
        margin: EdgeInsets.only(left: 94.h, right: 90.h, bottom: 27.v),
        buttonTextStyle: CustomTextStyles.headlineSmallPoppinsOnError,
        onPressed: () {
          onTapLoginButton(context);
        });
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapLoginButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
