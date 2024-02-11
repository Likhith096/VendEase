import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';

class ProductlistsectionItemWidget extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String imageUrl;
  int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  ProductlistsectionItemWidget({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.imageUrl,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Updated widget to include plus-minus functionality
    return ListTile(
      leading: imageUrl.isNotEmpty
          ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
          : Icon(Icons.image, size: 50), // Placeholder icon in case of no image URL
      title: Text(productName),
      subtitle: Text('Price: $productPrice, Quantity: $quantity'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: onRemove,
          ),
          Text('$quantity'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}

class CartsPage extends StatefulWidget {
  const CartsPage({Key? key}) : super(key: key);

  @override
  _CartsPageState createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  Future<List<QueryDocumentSnapshot>> fetchCartItems() async {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  var querySnapshot = await FirebaseFirestore.instance
      .collection('carts')
      .where('userId', isEqualTo: userId)
      .get();
  return querySnapshot.docs; // This is inherently a List<QueryDocumentSnapshot>
}



  void updateCartQuantity(String docId, int change) async {
  // Reference to the cart document
  DocumentReference cartRef = FirebaseFirestore.instance.collection('carts').doc(docId);

  // Assuming there's a straightforward way to reference the corresponding order document
  // This might need adjustment based on your actual data model
  DocumentReference orderRef = FirebaseFirestore.instance.collection('Orders').doc(docId);

  FirebaseFirestore.instance.runTransaction((transaction) async {
    // Get the current cart item snapshot
    DocumentSnapshot cartSnapshot = await transaction.get(cartRef);

    if (!cartSnapshot.exists) {
      throw Exception("Cart item does not exist!");
    }

    // Assuming the order item has a similar quantity field
    // Get the current order item snapshot
    DocumentSnapshot orderSnapshot = await transaction.get(orderRef);

    if (!orderSnapshot.exists) {
      throw Exception("Order item does not exist!");
    }

    // Update quantity in both cart and order documents
    int newQuantity = (cartSnapshot['quantity'] as int) + change;
    if (newQuantity > 0) {
      transaction.update(cartRef, {'quantity': newQuantity});
      transaction.update(orderRef, {'quantity': newQuantity}); // Update the order document similarly
    } else {
      // Optionally remove the item from both collections if its quantity reaches 0
      transaction.delete(cartRef);
      transaction.delete(orderRef); // Delete the order document similarly
    }
  }).then((result) {
    // Refresh the UI after updating the documents
    setState(() {});
  }).catchError((error) {
    print("Failed to update documents: $error");
  });
}


  double calculateTotalPrice(List<QueryDocumentSnapshot> cartItems) {
  double totalPrice = 0.0;
  for (var item in cartItems) {
    final data = item.data() as Map<String, dynamic>; // Correctly cast data
    final double price = data['price'].toDouble(); // Ensure this is double and use toDouble() for safety
    final int quantity = data['quantity'] as int;
    totalPrice += price * quantity;
  }
  return totalPrice;
}


//   void addProduct(String productId) async {
//   print('Adding product: $productId');

//   Product? productDetail = products.firstWhere(
//     (p) => p.id == productId,
//     orElse: () => Product(id: '', name: '', price: 0.0, weight: 0.0, imageURL: ''),
//   );

//   if (productDetail.id.isEmpty) {
//     print('Product not found in the list');
//     return;
//   }

//   setState(() {
//     productQuantities[productId] = (productQuantities[productId] ?? 0) + 1;
//   });

//   String userId = getCurrentUserId();
//   if (userId.isEmpty) {
//     print('User ID is empty');
//     return;
//   }

//   DocumentReference cartRef = FirebaseFirestore.instance.collection('carts').doc(productId);
//   DocumentReference orderRef = FirebaseFirestore.instance.collection('Orders').doc(productId); // Reference to Orders collection

//   FirebaseFirestore.instance.runTransaction((transaction) async {
//     try {
//       DocumentSnapshot cartSnapshot = await transaction.get(cartRef);
//       DocumentSnapshot orderSnapshot = await transaction.get(orderRef); // Get the current order snapshot

//       int newQuantity = 1;
//       if (cartSnapshot.exists) {
//         newQuantity = cartSnapshot['quantity'] + 1;
//         transaction.update(cartRef, {'quantity': newQuantity});
//       } else {
//         transaction.set(cartRef, {
//           'productId': productId,
//           'userId': userId,
//           'quantity': newQuantity,
//           'price': productDetail.price,
//           'name': productDetail.name,
//           'imageURL': productDetail.imageURL,
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//       }

//       // Update or set in the Orders collection similarly
//       if (orderSnapshot.exists) {
//         transaction.update(orderRef, {'quantity': newQuantity});
//       } else {
//         transaction.set(orderRef, {
//           'productId': productId,
//           'userId': userId,
//           'quantity': newQuantity,
//           'price': productDetail.price,
//           'name': productDetail.name,
//           'imageURL': productDetail.imageURL,
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//       }
//     } catch (e) {
//       print('Error updating cart and orders: $e');
//     }
//   });
// }



//   void removeProduct(String productId) async {
//   if (!productQuantities.containsKey(productId) || productQuantities[productId]! <= 0) {
//     print('Product quantity is already 0 or not in cart');
//     return;
//   }

//   setState(() {
//     productQuantities[productId] = productQuantities[productId]! - 1;
//   });

//   DocumentReference cartRef = FirebaseFirestore.instance.collection('carts').doc(productId);
//   DocumentReference orderRef = FirebaseFirestore.instance.collection('Orders').doc(productId); // Reference to Orders collection

//   FirebaseFirestore.instance.runTransaction((transaction) async {
//     DocumentSnapshot cartSnapshot = await transaction.get(cartRef);
//     DocumentSnapshot orderSnapshot = await transaction.get(orderRef); // Get the current order snapshot

//     if (cartSnapshot.exists && cartSnapshot['quantity'] > 1) {
//       int newQuantity = cartSnapshot['quantity'] - 1;
//       transaction.update(cartRef, {'quantity': newQuantity});
//       transaction.update(orderRef, {'quantity': newQuantity}); // Update Orders collection
//     } else {
//       transaction.delete(cartRef);
//       transaction.delete(orderRef); // Remove from Orders collection if quantity becomes 0
//     }
//   });
// }


  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Text('Your cart is empty');
          } else {
            final cartItems = snapshot.data!;
            final totalPrice = calculateTotalPrice(cartItems);
            return Column(
              children: [
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
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final data = cartItems[index].data() as Map<String, dynamic>;
                      return ProductlistsectionItemWidget(
                        productName: data['name'] ?? '',
                        productPrice: data['price'].toString(),
                        quantity: data['quantity'],
                        imageUrl: data['imageURL'] ?? '',
                        onAdd: () => updateCartQuantity(cartItems[index].id, 1),
                        onRemove: () => updateCartQuantity(cartItems[index].id, -1),
                      );
                    },
                  ),
                ),
                _buildProceedToPaySection(context, totalPrice),
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


