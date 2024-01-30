import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/app_bar/appbar_leading_image.dart';
import 'package:vendeaze/widgets/app_bar/custom_app_bar.dart';

class ConfirmedScreen extends StatelessWidget {
  const ConfirmedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 7.v),
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 23.h),
                        decoration: AppDecoration.outlinePrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder34),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text("Confirmed", style: theme.textTheme.titleLarge),
                          SizedBox(height: 66.v),
                          CustomImageView(
                              imagePath: ImageConstant.imgIconCheckCircled,
                              height: 118.v,
                              width: 126.h),
                          SizedBox(height: 9.v),
                          _buildSummary(context),
                          SizedBox(height: 38.v),
                          Text("A receipt will be sent directly to the email",
                              style: theme.textTheme.bodyMedium),
                          SizedBox(height: 91.v),
                          _buildFrame(context)
                        ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgFrame13,
            margin: EdgeInsets.only(left: 4.h, right: 344.h),
            onTap: () {
              onTapImage(context);
            }),
        styleType: Style.bgShadow);
  }

  /// Section Widget
  Widget _buildSummary(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            margin: EdgeInsets.only(right: 14.h),
            padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 12.v),
            decoration: AppDecoration.outlinePrimaryContainer
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: Text("Payment Detail",
                          style: theme.textTheme.titleMedium)),
                  SizedBox(height: 7.v),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: _buildEight(context,
                          totalText: "Order No.",
                          priceText: "1485156215495612")),
                  SizedBox(height: 7.v),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: _buildEight(context,
                          totalText: "Total", priceText: " 34.00")),
                  SizedBox(height: 7.v),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: _buildEight(context,
                          totalText: "Date & Time",
                          priceText: "05.11.2023 - 21:29:10")),
                  SizedBox(height: 8.v),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: _buildEight(context,
                          totalText: "Payment Method", priceText: "PAYTM")),
                  SizedBox(height: 6.v),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: _buildEight(context,
                          totalText: "Name", priceText: "ASHUTOSH SHARMA")),
                  SizedBox(height: 7.v),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: _buildEight(context,
                          totalText: "Email",
                          priceText: "ashutoshuix@gmail.com"))
                ])));
  }

  /// Section Widget
  Widget _buildFrame(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 4.h),
        decoration: AppDecoration.outlinePrimaryContainer1,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 141.h, vertical: 11.v),
            decoration: AppDecoration.fillOnErrorContainer
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
            child: Text("Done", style: CustomTextStyles.titleMediumPrimary)));
  }

  /// Common widget
  Widget _buildEight(
    BuildContext context, {
    required String totalText,
    required String priceText,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(totalText,
          style: theme.textTheme.labelLarge!
              .copyWith(color: theme.colorScheme.errorContainer)),
      Text(priceText,
          style: CustomTextStyles.bodySmallErrorContainer
              .copyWith(color: theme.colorScheme.errorContainer))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }
}
