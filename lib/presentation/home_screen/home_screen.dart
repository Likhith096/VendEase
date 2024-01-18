import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/presentation/carts_page/carts_page.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key})
      : super(
          key: key,
        );

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            _buildLocationRow(context),
            Text(
              "CATEGORIES",
              style: CustomTextStyles.headlineLargePrimaryContainer,
            ),
            SizedBox(height: 14.v),
            _buildCategoriesRow(context),
            SizedBox(height: 55.v),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.h),
        child: _buildBottomBar(context),
      ),
    ),
  );
}



  /// Section Widget
  Widget _buildLocationRow(BuildContext context) {
    return SizedBox(
      height: 100.v,
      width: 389.h,
      // height: MediaQuery.of(context).size.height*0.3,
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 7.h,
                vertical: 34.v,
              ),
              decoration: AppDecoration.fillPink.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder40,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgMdiLocation,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    margin: EdgeInsets.only(top: 6.v),
                  ),
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.headlineSmall, // Adjusted this line
                  ),
                ],
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgVendeaselogoRemovebgPreview164x255,
            height: 80.v,
            width: 136.h,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }

  /// Section Widget
Widget _buildCategoriesRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
    padding: EdgeInsets.symmetric(horizontal: 31.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgRectangle11,
          height: 256.v,
          width: 250.h,
          radius: BorderRadius.circular(24.h),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgRectangle12,
          height: 256.v,
          width: 30.h,
          radius: BorderRadius.circular(15.h),
          margin: EdgeInsets.only(left: 55.h),
        ),
      ],
    ),
    );
}


/// Section Widget
Widget _buildBottomBar(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, getCurrentRoute(BottomBarEnum.Heroiconssolidhome));
    },
    child: CustomBottomBar(
      onChanged: getCurrentRoute,
    ),
  );
}

/// Handling route based on bottom click actions
String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
    case BottomBarEnum.Heroiconssolidhome:
      return AppRoutes.cartsPageContainerScreen;
    case BottomBarEnum.Search:
      return AppRoutes.searchPageScreen;
    case BottomBarEnum.User:
      return AppRoutes.profileScreen;
    default:
      return "/";
  }
}

/// Handling page based on route
Widget getCurrentPage(String currentRoute) {
  switch (currentRoute) {
    case AppRoutes.cartsPage:
      return CartsPage();
    default:
      return DefaultWidget();
  }
}

}
