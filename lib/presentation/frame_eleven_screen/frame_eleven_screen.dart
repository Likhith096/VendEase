import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';

class FrameElevenScreen extends StatefulWidget {
  const FrameElevenScreen({Key? key}) : super(key: key);

  @override
  _FrameElevenScreenState createState() => _FrameElevenScreenState();
}

class _FrameElevenScreenState extends State<FrameElevenScreen> {
  double logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the logo animation after a slight delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        logoOpacity = 1.0;
      });
    });
  }

 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: logoOpacity,
                duration: Duration(seconds: 2),
                child: _buildWidgetStack(context),
              ),
              SizedBox(height: 23.v),
              Text(
                "Sign up success!",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.headlineLargePurple400,
              ),
              SizedBox(height: 2.v),
              SizedBox(height: 50.v), // Added more space before the button
              _buildLoginButton(context),
            ],
          ),
        ),
      ),
    );
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
    return Padding(
      padding: EdgeInsets.all(16.h), // Changed to a uniform padding
      child: CustomElevatedButton(
        height: 46.v,
        text: "LOGIN".toUpperCase(),
        buttonTextStyle: CustomTextStyles.headlineSmallPoppinsOnError,
        onPressed: () => onTapLoginButton(context),
        // Removed margin and width to allow the button to expand
      ),
    );
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapLoginButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
