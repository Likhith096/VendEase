// import 'package:another_stepper/dto/stepper_data.dart';
// import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.purple50,
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 28.v),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          height: 32.v,
                          width: 224.h,
                          child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgArrowLeft,
                                    height: 30.v,
                                    width: 214.h,
                                    alignment: Alignment.topLeft,
                                    onTap: () {
                                      onTapImgArrowLeft(context);
                                    }),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text("Summary",
                                        style: theme.textTheme.titleLarge))
                              ]))),
                  SizedBox(height: 35.v),
                  //_buildStepper(context),
                  SizedBox(height: 45.v),
                  _buildSummary(context),
                  Spacer(),
                  Divider(indent: 40.h, endIndent: 39.h),
                  SizedBox(height: 24.v),
                  Padding(
                      padding: EdgeInsets.only(left: 3.h, right: 13.h),
                      child: _buildDeliveryTime(context,
                          deliveryTimeText: "Total Price", timeText: " 34")),
                  SizedBox(height: 6.v),
                  Padding(
                      padding: EdgeInsets.only(left: 3.h, right: 13.h),
                      child: _buildDeliveryTime(context,
                          deliveryTimeText: "Delivery Time",
                          timeText: "27mins")),
                  SizedBox(height: 24.v),
                  CustomElevatedButton(
                      text: "Pay Now",
                      margin: EdgeInsets.only(left: 18.h, right: 19.h),
                      onPressed: (){
                        ontap(context);
                      }),
                  SizedBox(height: 51.v)
                ]))));
  }

void ontap(BuildContext context)
{
  Navigator.pushNamed(context,AppRoutes.paymentCardScreen);
}
  // Widget _buildStepper(BuildContext context) {
  //   return CustomStepper(
  //     activeIndex: 0, // Set the active index as needed
  //     stepperList: ["Step 1", "Step 2", "Step 3"], // Customize the steps
  //   );
  // }  /// Section Widget
  // Widget _buildStepper(BuildContext context) {
  //   return AnotherStepper(
  //       iconHeight: 23,
  //       iconWidth: 318,
  //       stepperDirection: Axis.horizontal,
  //       activeIndex: 0,
  //       barThickness: 3,
  //       inverted: true,
  //       stepperList: [
  //         StepperData(
  //             iconWidget: SizedBox(
  //                 height: 23.v,
  //                 width: 318.h,
  //                 child: Stack(alignment: Alignment.center, children: [
  //                   Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: Container(
  //                           height: 23.v,
  //                           width: 25.h,
  //                           padding: EdgeInsets.all(7.h),
  //                           decoration: AppDecoration.fillPrimary.copyWith(
  //                               borderRadius: BorderRadiusStyle.circleBorder12),
  //                           child: CustomImageView(
  //                               imagePath: ImageConstant.imgCheckmark,
  //                               height: 8.v,
  //                               width: 11.h,
  //                               alignment: Alignment.topCenter))),
  //                   CustomImageView(
  //                       imagePath: ImageConstant.imgGroup8,
  //                       height: 1.v,
  //                       width: 311.h,
  //                       alignment: Alignment.center)
  //                 ]))),
  //         StepperData(),
  //         StepperData()
  //       ]);
  // }

  /// Section Widget
  Widget _buildSummary(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.v),
        decoration: AppDecoration.outlinePrimaryContainer
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Summary", style: theme.textTheme.titleMedium),
              SizedBox(height: 6.v),
              SizedBox(
                  height: 111.v,
                  width: 295.h,
                  child: Stack(alignment: Alignment.topLeft, children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 108.v,
                            width: 295.h,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: theme.colorScheme.onPrimary,
                                        width: 1.h))))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(top: 1.v),
                            child: Text("Veg Burger",
                                style: theme.textTheme.titleSmall))),
                    Align(
                        alignment: Alignment.topRight,
                        child:
                            Text(" 9.89", style: theme.textTheme.titleSmall)),
                    Padding(
                        padding: EdgeInsets.only(top: 24.v, bottom: 64.v),
                        child: _buildOrderListAndPrice(context,
                            menuItemName: "Garlic Bread",
                            menuItemPrice: " 6.67")),
                    Padding(
                        padding: EdgeInsets.only(top: 48.v, bottom: 38.v),
                        child: _buildOrderListAndPrice(context,
                            menuItemName: "Farmer’s PIzza",
                            menuItemPrice: " 10.00")),
                    Padding(
                        padding: EdgeInsets.only(top: 72.v, bottom: 11.v),
                        child: _buildOrderListAndPrice(context,
                            menuItemName: "Pepsi", menuItemPrice: " 4.69"))
                  ])),
              SizedBox(height: 12.v),
              _buildOrderListAndPrice(context,
                  menuItemName: "Subtotal", menuItemPrice: " 31.69"),
              SizedBox(height: 4.v),
              _buildOrderListAndPrice(context,
                  menuItemName: "Service fee", menuItemPrice: " 2.31"),
              SizedBox(height: 4.v),
              _buildOrderListAndPrice(context,
                  menuItemName: "Total", menuItemPrice: " 34 ")
            ]));
  }

  /// Common widget
  Widget _buildOrderListAndPrice(
    BuildContext context, {
    required String menuItemName,
    required String menuItemPrice,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 4.v),
          child: Text(menuItemName,
              style: theme.textTheme.titleSmall!
                  .copyWith(color: theme.colorScheme.errorContainer))),
      Padding(
          padding: EdgeInsets.only(bottom: 4.v),
          child: Text(menuItemPrice,
              style: theme.textTheme.titleSmall!
                  .copyWith(color: theme.colorScheme.errorContainer)))
    ]);
  }

  /// Common widget
  Widget _buildDeliveryTime(
    BuildContext context, {
    required String deliveryTimeText,
    required String timeText,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 7.v),
          child: Text(deliveryTimeText,
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.primaryContainer.withOpacity(1)))),
      Text(timeText,
          style: CustomTextStyles.titleLargeInterPrimary
              .copyWith(color: theme.colorScheme.primary))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
