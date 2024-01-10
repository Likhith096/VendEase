import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/presentation/carts_page/carts_page.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class HomeWithCartScreen extends StatelessWidget {
  HomeWithCartScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  _buildLocationRow(context),
                  Spacer(),
                  Text("CATEGORIES",
                      style: CustomTextStyles.headlineLargePurple400),
                  SizedBox(height: 24.v),
                  _buildCategoriesRow(context),
                  SizedBox(height: 24.v),
                  _buildCartRow(context),
                  SizedBox(height: 32.v)
                ])),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.only(left: 11.h, right: 7.h),
                child: _buildBottomBar(context))));
  }

  /// Section Widget
  Widget _buildLocationRow(BuildContext context) {
    return SizedBox(
        height: 100.v,
        width: 389.h,
        child: Stack(alignment: Alignment.centerRight, children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.h, vertical: 31.v),
                  decoration: AppDecoration.fillPink.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder40),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgMdiLocation,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                            margin: EdgeInsets.only(top: 9.v, bottom: 3.v)),
                        Padding(
                            padding: EdgeInsets.only(top: 6.v),
                            child: Text("Location",
                                style: theme.textTheme.titleLarge))
                      ]))),
          CustomImageView(
              imagePath: ImageConstant.imgVendeaselogoRemovebgPreview164x255,
              height: 80.v,
              width: 136.h,
              alignment: Alignment.centerRight)
        ]));
  }

  /// Section Widget
  Widget _buildCategoriesRow(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(left: 38.h, right: 15.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgRectangle11256x250,
                  height: 256.v,
                  width: 250.h,
                  radius: BorderRadius.circular(24.h)),
              CustomImageView(
                  imagePath: ImageConstant.imgRectangle12,
                  height: 256.v,
                  width: 30.h,
                  radius: BorderRadius.circular(15.h),
                  margin: EdgeInsets.only(left: 55.h))
            ])));
  }

  /// Section Widget
  Widget _buildCartRow(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 14.h, right: 23.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 2.v),
        decoration: AppDecoration.outlineOnError3,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("1 Item | ₹20", style: theme.textTheme.headlineLarge),
          GestureDetector(
              onTap: () {
                onTapTxtViewCart(context);
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 8.v, right: 18.h, bottom: 3.v),
                  child: Text("View Cart",
                      style: CustomTextStyles
                          .headlineMediumLondrinaSolidPurpleA200)))
        ]));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Heroiconssolidhome:
        return AppRoutes.cartsPage;
      case BottomBarEnum.Search:
        return "/";
      case BottomBarEnum.User:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.cartsPage:
        return CartsPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the cartsPageContainerScreen when the action is triggered.
  onTapTxtViewCart(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cartsPageContainerScreen);
  }
}
