import '../search_page_screen/widgets/productcard1_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/presentation/carts_page/carts_page.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';
import 'package:vendeaze/widgets/custom_search_view.dart';

class SearchPageScreen extends StatelessWidget {
  SearchPageScreen({Key? key})
      : super(
          key: key,
        );

  final TextEditingController searchController = TextEditingController();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle65,
                height: 55.v,
                width: 390.h,
              ),
              SizedBox(height: 26.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "Search For Products",
                ),
              ),
              SizedBox(height: 32.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 33.h),
                  child: Text(
                    "Search Results",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(height: 76.v),
              _buildSearchPage(context),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            right: 13.h,
          ),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Text(
              "Top Picks",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 24.v),
          SizedBox(
            height: 216.v,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 1.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (
                context,
                index,
              ) {
                return SizedBox(
                  width: 29.h,
                );
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                return Productcard1ItemWidget();
              },
            ),
          ),
        ],
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