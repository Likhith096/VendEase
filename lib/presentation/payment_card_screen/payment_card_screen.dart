import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/app_bar/appbar_title.dart';
import 'package:vendeaze/widgets/app_bar/appbar_title_image.dart';
import 'package:vendeaze/widgets/app_bar/custom_app_bar.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';
import 'package:vendeaze/widgets/custom_switch.dart';
import 'package:vendeaze/widgets/custom_text_form_field.dart';

class PaymentCardScreen extends StatelessWidget {
  PaymentCardScreen({Key? key}) : super(key: key);

  TextEditingController televisionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isSelectedSwitch = false;
  bool isSelectedSwitch1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 28.v),
            child: Container(
              decoration: AppDecoration.outlinePrimary.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder34,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 57.v),
                  _buildTelevisionColumn(context),
                  SizedBox(height: 23.v),
                  _buildNameColumn(context),
                  SizedBox(height: 23.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.h),
                      child: Text("Cardnumber", style: theme.textTheme.bodySmall),
                    ),
                  ),
                  SizedBox(height: 7.v),
                  Container(
                    height: 38.v,
                    margin: EdgeInsets.only(right: 5.h),
                    padding: EdgeInsets.all(13.h),
                    decoration: AppDecoration.outlinePrimaryContainer2.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder6,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgTelevision,
                      height: 11.v,
                      width: 16.h,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  SizedBox(height: 23.v),
                  Padding(
                    padding: EdgeInsets.only(left: 30.h, right: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildExpiryColumn(context),
                        _buildCvvColumn(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 41.v),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSwitch(
                          value: isSelectedSwitch,
                          onChange: (value) {
                            isSelectedSwitch = value;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 9.h),
                          child: Text(
                            "Remember this card",
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.v),
                  Padding(
                    padding: EdgeInsets.only(right: 63.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomSwitch(
                          value: isSelectedSwitch1,
                          onChange: (value) {
                            isSelectedSwitch1 = value;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 9.h),
                          child: Text(
                            "Send receipt to my email",
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 42.v),
                  Align(
                    alignment: Alignment.center,
                    child: Divider(indent: 44.h, endIndent: 33.h),
                  ),
                  SizedBox(height: 24.v),
                  _buildAmountPayableRow(context),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                    text: "Pay Now",
                    margin: EdgeInsets.only(left: 30.h, right: 5.h),
                    onPressed: () {
                      ontap(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void ontap(BuildContext context)
  {
     Navigator.pushNamed(context,AppRoutes.confirmedScreen);
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 60.v,
        title: Container(
            height: 32.64.v,
            width: 222.h,
            margin: EdgeInsets.only(left: 26.h),
            child: Stack(alignment: Alignment.bottomRight, children: [
              AppbarTitleImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(right: 8.h, bottom: 2.v),
                  onTap: () {
                    onTapArrowLeft(context);
                  }),
              AppbarTitle(
                  text: "Payment",
                  margin: EdgeInsets.only(left: 131.h, top: 2.v))
            ])));
  }



  /// Section Widget
   Widget _buildTelevisionColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30.h, right: 5.h),
      decoration: AppDecoration.outlinePrimaryContainer1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Payment Method", style: theme.textTheme.bodySmall),
          SizedBox(height: 5.v),
          CustomTextFormField(
            controller: televisionController,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(13.h, 13.v, 30.h, 13.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgTelevision,
                height: 11.v,
                width: 16.h,
              ),
            ),
            prefixConstraints: BoxConstraints(maxHeight: 38.v),
          ),
        ],
      ),
    );
  }


  /// Section Widget
  Widget _buildNameColumn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 30.h, right: 5.h),
        decoration: AppDecoration.outlinePrimaryContainer1
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder6),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cardholder Name", style: theme.textTheme.bodySmall),
              SizedBox(height: 7.v),
              CustomTextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.done,
                  prefix: Container(
                      margin: EdgeInsets.fromLTRB(13.h, 11.v, 30.h, 11.v),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgContrast,
                          height: 16.adaptSize,
                          width: 16.adaptSize)),
                  prefixConstraints: BoxConstraints(maxHeight: 38.v))
            ]));
  }

  /// Section Widget
  Widget _buildExpiryColumn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 1.v),
        decoration: AppDecoration.outlinePrimaryContainer1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Expiry", style: theme.textTheme.bodySmall),
          SizedBox(height: 6.v),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                height: 38.v,
                width: 88.h,
                padding: EdgeInsets.all(13.h),
                decoration: AppDecoration.outlinePrimaryContainer2
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder6),
                child: CustomImageView(
                    imagePath: ImageConstant.imgThumbsUp,
                    height: 12.v,
                    width: 11.h,
                    alignment: Alignment.centerLeft)),
            Padding(
                padding: EdgeInsets.only(top: 9.v, bottom: 10.v),
                child: Text("MM/YY", style: CustomTextStyles.bodySmallPrimary))
          ])
        ]));
  }

  /// Section Widget
  Widget _buildCvvColumn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 22.h),
        decoration: AppDecoration.outlinePrimaryContainer1
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder6),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("CVV", style: theme.textTheme.bodySmall),
              SizedBox(height: 7.v),
              Container(
                  width: 88.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 48.h, vertical: 9.v),
                  decoration: AppDecoration.outlinePrimaryContainer2
                      .copyWith(borderRadius: BorderRadiusStyle.roundedBorder6),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 1.v),
                        Text("***", style: CustomTextStyles.bodySmallPrimary)
                      ]))
            ]));
  }

  /// Section Widget
  Widget _buildAmountPayableRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 5.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(top: 7.v),
              child: Text("Amount Payable", style: theme.textTheme.bodyLarge)),
          Text(" 34", style: CustomTextStyles.titleLargeInterPrimary)
        ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
