import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';

// ignore: must_be_immutable
class ProductlistsectionItemWidget extends StatelessWidget {
  const ProductlistsectionItemWidget({Key? key, required String productPrice})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 2.v,
      ),
      decoration: AppDecoration.fillPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 48.v,
            width: 60.h,
            margin: EdgeInsets.only(
              top: 2.v,
              bottom: 3.v,
            ),
            padding: EdgeInsets.symmetric(horizontal: 9.h),
            decoration: AppDecoration.outlineOnError1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.img21,
                  height: 47.v,
                  width: 40.h,
                  alignment: Alignment.center,
                ),
                CustomImageView(
                  imagePath: ImageConstant.img21,
                  height: 47.v,
                  width: 40.h,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              bottom: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 23.v,
                  width: 79.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Lays Chips",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Lays Chips",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.v),
                Container(
                  height: 18.v,
                  width: 35.h,
                  margin: EdgeInsets.only(left: 4.h),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "33gm",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "33gm",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 67,
          ),
          Container(
            height: 30.v,
            width: 79.h,
            margin: EdgeInsets.only(
              top: 14.v,
              bottom: 9.v,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 25.v,
                    width: 79.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      border: Border.all(
                        color: theme.colorScheme.onPrimary,
                        width: 1.h,
                        strokeAlign: strokeAlignOutside,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.onError,
                          spreadRadius: 2.h,
                          blurRadius: 2.h,
                          offset: Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 30.v,
                    width: 52.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "-  1  +",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "-  1  +",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 32,
          ),
          Container(
            height: 23.v,
            width: 36.h,
            margin: EdgeInsets.only(
              top: 17.v,
              right: 3.h,
              bottom: 13.v,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Rs 10",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Rs 10",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
