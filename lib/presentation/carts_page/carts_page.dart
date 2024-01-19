import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../carts_page/widgets/productlist_item_widget.dart';
import '../carts_page/widgets/productlistsection_item_widget.dart';

// ignore_for_file: must_be_immutable
class CartsPage extends StatelessWidget {
  const CartsPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillPrimary,
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle81,
                height: 55.v,
                width: 390.h,
              ),
              SizedBox(height: 37.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 22.v,
                  width: 213.h,
                  margin: EdgeInsets.only(left: 10.h),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Selected  Products",
                          style: CustomTextStyles.bodyLargeKronaOne,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Selected  Products",
                          style: CustomTextStyles.bodyLargeKronaOne,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.v),
              _buildProductListSection(context),
              Spacer(),
              _buildTopPicksSection(context),
              SizedBox(height: 49.v),
              _buildProceedToPaySection(context),
              SizedBox(height: 9.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProductListSection(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          height: 9.v,
        );
      },
      itemCount: 2,
      itemBuilder: (context, index) {
        return ProductlistsectionItemWidget();
      },
    );
  }

  /// Section Widget
  Widget _buildTopPicksSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26.v,
            width: 79.h,
            margin: EdgeInsets.only(left: 5.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Top Picks",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Top Picks",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
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
                return ProductlistItemWidget();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProceedToPaySection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 58.v,
            width: 101.h,
            padding: EdgeInsets.symmetric(
              horizontal: 29.h,
              vertical: 4.v,
            ),
            decoration: AppDecoration.outlineOnError2,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Bill",
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Bill",
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomElevatedButton(
              height: 58.v,
              text: "Proceed to Pay",
              buttonStyle: CustomButtonStyles.outlineOnError,
              buttonTextStyle: CustomTextStyles.headlineMedium28,
            ),
          ),
        ],
      ),
    );
  }
}
