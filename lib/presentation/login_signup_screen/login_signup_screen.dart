import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
        body: SizedBox(
          height: SizeUtils.height,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 37.h, vertical: 195.v),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageConstant.imgGroup73),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                              style: CustomTextStyles.displayMediumBlack),
                        ),
                      ),
                      SizedBox(height: 22.v),
                      buildButton(
                        context: context,
                        text: "Login",
                        onTap: () {
                          onTapView(context);
                        },
                      ),
                      SizedBox(height: 81.v),
                      buildButton(
                        context: context,
                        text: "Sign Up",
                        onTap: () {
                          onTapView1(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              buildTopRightLogo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({required BuildContext context, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64.v,
        width: 306.h,
        decoration: BoxDecoration(
          color: appTheme.pink100,
          borderRadius: BorderRadius.circular(32.h),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: CustomTextStyles.displayMediumOnError,
          ),
        ),
      ),
    );
  }

  Widget buildTopRightLogo() {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 174.v,
        width: 162.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgEllipse3,
              height: 174.v,
              width: 162.h,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgVendeaselogoRemovebgPreview131x162,
              height: 131.v,
              width: 162.h,
              margin: EdgeInsets.only(top: 18.v),
            ),
          ],
        ),
      ),
    );
  }

  onTapView(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  onTapView1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}