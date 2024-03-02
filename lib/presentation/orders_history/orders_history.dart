import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
// Assuming ProductlistItemWidget is correctly defined elsewhere

class ProductlistsectionItemWidget extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String quantity;
  final String imageUrl;

  const ProductlistsectionItemWidget({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget to display each product in the cart
    return ListTile(
      leading: imageUrl.isNotEmpty
          ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
          : Icon(Icons.image, size: 50), // Placeholder icon in case of no image URL
      title: Text(productName),
      subtitle: Text('Price: $productPrice, Quantity: $quantity'),
    );
  }
}

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    print("Attempting to fetch orders for User ID: $userId");
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('orderHistory').where('userId', isEqualTo: userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Text('You havenot Ordered anything till now');
            } else {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.pink[100], // Light pink color
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Text(
                      "Order History",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Your existing UI code...
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        return ProductlistsectionItemWidget(
                          productName: data['name'] ?? '',
                          productPrice: data['price'].toString(),
                          quantity: data['quantity'].toString(),
                          imageUrl: data['imageURL'] ?? '', // Ensure this matches your field name
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void onTapPtoP(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paymentScreen);
  }
}