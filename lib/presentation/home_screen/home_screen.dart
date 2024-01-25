import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/presentation/carts_page/carts_page.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';
import '../products_page_screen/products_page_screen.dart';
//import '../products_page_screen/widgets/productcard_item_widget.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLocationRow(context),
              SizedBox(height: 14.v),
              _buildCategoriesRow(context),
              Text(
                "CATEGORIES",
                style: CustomTextStyles.headlineLargePrimaryContainer,
              ),
              SizedBox(height: 55.v),
              // _buildProductCard(context),
              // SizedBox(height: 30.v), // Replace Spacer with a SizedBox
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }
// Widget _buildProductCard(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 24.h,
//         right: 17.h,
//       ),
//       child: GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           mainAxisExtent: 216.v,
//           crossAxisCount: 2,
//           mainAxisSpacing: 29.h,
//           crossAxisSpacing: 29.h,
//         ),
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           return ProductcardItemWidget(
//             onAddPressed: () {
//        Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ProductsPageScreen(
//                   categoryName: 'Your Category Name', // Provide the category name if needed
//                 ),
//                 ));},
//           );
//         },
//       ),
//     );
//   }



  /// Section Widget
  Widget _buildLocationRow(BuildContext context) {
    return SizedBox(
      height: 100.v,
      width: 389.h,
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
  // Updated list with category name and image path
  final List<Map<String, String>> categories = [
    {"name": "Category1", "image": ImageConstant.imgCat1},
    {"name": "Category2", "image": ImageConstant.imgCat2},
    {"name": "Category3", "image": ImageConstant.imgCat3},
    // ... other categories
  ];

  return Container(
    height: 324.v, // Set a fixed height for the container
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 31.h : 55.h,
            right: index == categories.length - 1 ? 31.h : 0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsPageScreen(
                    // Pass the selected category name to the ProductsPageScreen
                    categoryName: categories[index]["name"]!,
                  ),
                ),
              );
            },
            child: CustomImageView(
              imagePath: categories[index]["image"]!,
              height: 324.v,
              width: 280.h,
              radius: BorderRadius.circular(24.h),
            ),
          ),
        );
      },
    ),
  );
}


/// Section Widget
Widget _buildBottomBar(BuildContext context) {
  return CustomBottomBar(
    onChanged: (BottomBarEnum type) {
      // This callback can be used to update the state of HomeScreen if needed.
    },
  );
}


/// Handling page based on route
Widget getCurrentPage(String currentRoute) {
  switch (currentRoute) {
    case AppRoutes.cartsPage:
      return CartsPage();
    default:
      return HomeScreen();
  }
}
}
