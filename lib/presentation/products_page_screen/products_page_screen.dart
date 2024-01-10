import '../products_page_screen/widgets/productcard_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/presentation/carts_page/carts_page.dart';
import 'package:vendeaze/widgets/app_bar/appbar_leading_image.dart';
import 'package:vendeaze/widgets/app_bar/appbar_title.dart';
import 'package:vendeaze/widgets/app_bar/custom_app_bar.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';

class ProductsPageScreen extends StatelessWidget {
  ProductsPageScreen({Key? key})
      : super(
          key: key,
        );

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 55.v),
              _buildProductCard(context),
              Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 11.h,
            right: 23.h,
          ),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 54.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrow3,
        margin: EdgeInsets.only(
          left: 22.h,
          top: 45.v,
          bottom: 28.v,
        ),
      ),
      title: AppbarTitle(
        text: "Snacks",
        margin: EdgeInsets.only(
          left: 30.h,
          top: 25.v,
          bottom: 4.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildProductCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.h,
        right: 17.h,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 216.v,
          crossAxisCount: 2,
          mainAxisSpacing: 29.h,
          crossAxisSpacing: 29.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ProductcardItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
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
}
