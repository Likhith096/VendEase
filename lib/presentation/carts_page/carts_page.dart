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

class CartsPage extends StatelessWidget {
  const CartsPage({Key? key}) : super(key: key);

  double calculateTotalPrice(List<QueryDocumentSnapshot> cartItems) {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      final data = item.data() as Map<String, dynamic>;
      final price = data['price'] as double;
      final quantity = data['quantity'] as int;
      totalPrice += price * quantity;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    print("Attempting to fetch cart for User ID: $userId");
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('carts').where('userId', isEqualTo: userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Text('Your cart is empty');
            } else {
              final totalPrice = calculateTotalPrice(snapshot.data!.docs);
              return Column(
                children: [
                  // Light pink header with "Cart"
                  Container(
                    width: double.infinity,
                    color: Colors.pink[100], // Light pink color
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Text(
                      "Cart",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        return ProductlistsectionItemWidget(
                          productName: data['name'] ?? '',
                          productPrice: data['price'].toString(),
                          quantity: data['quantity'].toString(),
                          imageUrl: data['imageURL'] ?? '', // Assuming imageURL fetching is correctly implemented
                        );
                      },
                    ),
                  ),
                  _buildProceedToPaySection(context, totalPrice),
                  const SizedBox(height: 9),
                ],
              );
            }
          },
        ),
      ),
    );
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

}


