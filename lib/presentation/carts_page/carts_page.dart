import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
// import '../carts_page/widgets/productlist_item_widget.dart';
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
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0), // Reduce padding if necessary
    child: SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible( // Make the container flexible to avoid overflow
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: AppDecoration.outlineOnError2,
              child: Text(
                "Bill: ₹${totalPrice.toStringAsFixed(2)}",
                style: theme.textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis, // Prevent text overflow
              ),
            ),
          ),
          SizedBox(width: 10), // Add space between elements
          Expanded( // Use Expanded for the button to fill the remaining space
            child: CustomElevatedButton(
              text: "Proceed to Pay",
              onPressed: () => onTapPtoP(context),
            ),
          ),
        ],
      ),
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
