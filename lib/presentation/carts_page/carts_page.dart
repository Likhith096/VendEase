import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../carts_page/widgets/productlist_item_widget.dart';
// import '../carts_page/widgets/productlistsection_item_widget.dart';

class ProductlistsectionItemWidget extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String quantity;

  const ProductlistsectionItemWidget({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text(
                  "Selected Products",
                  style: CustomTextStyles.bodyLargeKronaOne,
                ),
              ),
            ),
            SizedBox(height: 16.v), // Add some space before the list tile
            ListTile(
              title: Text(productName),
              subtitle: Text('Price: $productPrice, Quantity: $quantity'),
            ),
            // ... Add more widgets or logic as needed
          ],
        ),
      ),
    );
  }
}


class CartsPage extends StatelessWidget {
  const CartsPage({Key? key}) : super(key: key);

  double calculateTotalPrice(List<QueryDocumentSnapshot> cartItems) {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      Map<String, dynamic> data = item.data() as Map<String, dynamic>;
      double price = data['price'];
      int quantity = data['quantity'];
      totalPrice += price * quantity;
    }
    return totalPrice;
  }

  Widget _buildProceedToPaySection(BuildContext context, double totalPrice) {
    return SizedBox(
  width: double.maxFinite,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 58.v,
        width: 150.h, // Increased width from 101.h to 150.h
        padding: EdgeInsets.symmetric(
          horizontal: 20.h, // Adjusted horizontal padding for better visibility
          vertical: 4.v,
        ),
        decoration: AppDecoration.outlineOnError2,
        child: Text(
          "Bill: ₹${totalPrice.toStringAsFixed(2)}",
          style: theme.textTheme.headlineMedium,
        ),
      ),
      Expanded(
        child: CustomElevatedButton(
          height: 58.v,
          text: "Proceed to Pay",
          buttonStyle: CustomButtonStyles.outlineOnError,
          buttonTextStyle: CustomTextStyles.headlineMedium28,
          onPressed: () {
            onTapPtoP(context);
          },
        ),
      ),
    ],
  ),
);
  }

  void onTapPtoP(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paymentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('carts')
              .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('Your cart is empty');
            } else {
              double totalPrice = calculateTotalPrice(snapshot.data!.docs);
              return Column(
                children: [
                  // Add other widgets like header, title, etc., if needed
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        return ProductlistsectionItemWidget(
                          productName: data['name'] ?? '',
                          productPrice: data['price'].toString(),
                          quantity: data['quantity'].toString(),
                        );
                      },
                    ),
                  ),
                  _buildProceedToPaySection(context, totalPrice),
                  SizedBox(height: 9.v),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  /// Section Widget
Widget _buildProductListSection(BuildContext context) {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  return FutureBuilder<QuerySnapshot>(
    future: FirebaseFirestore.instance
        .collection('carts')
        .where('userId', isEqualTo: userId)
        .get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Text('Your cart is empty');
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return ProductlistsectionItemWidget(
                productName: data['name'] ?? '',
                productPrice: data['price'].toString(),
                quantity: data['quantity'].toString(),
              );
            },
          ),
        );
      }
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
  // void onTapPtoP(BuildContext context) {
  // Navigator.pushNamed(context, AppRoutes.paymentScreen);
  // }

  /// Section Widget
  // Widget _buildProceedToPaySection(BuildContext context) {
  //   return SizedBox(
  //     width: double.maxFinite,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           height: 58.v,
  //           width: 101.h,
  //           padding: EdgeInsets.symmetric(
  //             horizontal: 29.h,
  //             vertical: 4.v,
  //           ),
  //           decoration: AppDecoration.outlineOnError2,
  //           child: Stack(
  //             alignment: Alignment.bottomRight,
  //             children: [
  //               Align(
  //                 alignment: Alignment.bottomRight,
  //                 child: Text(
  //                   "Bill",
  //                   style: theme.textTheme.headlineMedium,
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomRight,
  //                 child: Text(
  //                   "Bill",
  //                   style: theme.textTheme.headlineMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: CustomElevatedButton(
  //             height: 58.v,
  //             text: "Proceed to Pay",
  //             buttonStyle: CustomButtonStyles.outlineOnError,
  //             buttonTextStyle: CustomTextStyles.headlineMedium28,
  //             onPressed: () {
  //             onTapPtoP(context);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
