import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/models/product_model.dart';
import 'package:vendeaze/widgets/app_bar/appbar_leading_image.dart';
import 'package:vendeaze/widgets/app_bar/appbar_title.dart';
import 'package:vendeaze/widgets/app_bar/custom_app_bar.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';
import '../carts_page/carts_page.dart';

class ProductsPageScreen extends StatefulWidget {
  final String categoryName;

  ProductsPageScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  _ProductsPageScreenState createState() => _ProductsPageScreenState();
}

class _ProductsPageScreenState extends State<ProductsPageScreen> with WidgetsBindingObserver {
  Map<String, int> productQuantities = {};
  late Future<List<Product>> _productsFuture;
  List<Product> products = [];

  @override
  void initState() {
  super.initState();
  _productsFuture = fetchProductsFromFirestore();
  WidgetsBinding.instance.addObserver(this);
   fetchCartItemsFromFirestore(); // Fetch cart items after fetching products
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove the observer
    super.dispose();
  }

   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App is resumed - refresh the products and cart
      _refreshProductsAndCart();
    }
  }

  void _refreshProductsAndCart() {
    setState(() {
      _productsFuture = fetchProductsFromFirestore();
    });
    fetchCartItemsFromFirestore(); // Refresh cart items
  }
  Future<void> fetchCartItemsFromFirestore() async {
  String userId = getCurrentUserId();
  if (userId.isEmpty) {
    print('User ID is empty');
    return;
  }

  try {
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection('carts')
        .where('userId', isEqualTo: userId)
        .get();

    // Loop through each cart item and update productQuantities map
    for (var doc in cartSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      String productId = data['productId'];
      int quantity = data['quantity'];

      setState(() {
        productQuantities[productId] = quantity;
      });
    }
  } catch (error) {
    print('Error fetching cart items: $error');
  }
}


 Future<List<Product>> fetchProductsFromFirestore() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('Category', isEqualTo: widget.categoryName)
        .get();

    print("Category: ${widget.categoryName}");
    print("Number of products found: ${querySnapshot.docs.length}");

    List<Product> fetchedProducts = querySnapshot.docs.map((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        return Product(
          id: doc.id,
          category: data['Category'] ?? '',
          name: data['Name'] ?? '',
          price: (data['Price'] ?? 0.0).toDouble(),
          weight: (data['Weight'] ?? 0.0).toDouble(),
          imageURL: data['imageURL'] ?? '', // Make sure this matches your field name in Firestore
        );
      } else {
        throw Exception('Document data is null');
      }
    }).toList();



    this.products = fetchedProducts; // Store the fetched products in the state variable
    return fetchedProducts;
  } catch (error) {
    print('Error fetching products: $error');
    return []; // Return an empty list if fetching fails
  }
}


  String getCurrentUserId() {
      User? currentUser = FirebaseAuth.instance.currentUser;
      return currentUser?.uid ?? '';
    }


void addProduct(String productId) async {
  print('Adding product: $productId');

  Product? productDetail = products.firstWhere(
    (p) => p.id == productId,
    orElse: () => Product(id: '', category: '', name: '', price: 0.0, weight: 0.0, imageURL: ''),
  );

  if (productDetail.id.isEmpty) {
    print('Product not found in the list');
    return;
  }

  setState(() {
    productQuantities[productId] = (productQuantities[productId] ?? 0) + 1;
  });

  String userId = getCurrentUserId();
  if (userId.isEmpty) {
    print('User ID is empty');
    return;
  }

  DocumentReference cartRef = FirebaseFirestore.instance.collection('carts').doc(productId);
  DocumentReference orderRef = FirebaseFirestore.instance.collection('Orders').doc(productId); // Reference to Orders collection

  FirebaseFirestore.instance.runTransaction((transaction) async {
    try {
      DocumentSnapshot cartSnapshot = await transaction.get(cartRef);
      DocumentSnapshot orderSnapshot = await transaction.get(orderRef); // Get the current order snapshot

      int newQuantity = 1;
      if (cartSnapshot.exists) {
        newQuantity = cartSnapshot['quantity'] + 1;
        transaction.update(cartRef, {'quantity': newQuantity});
      } else {
        transaction.set(cartRef, {
          'productId': productId,
          'userId': userId,
          'quantity': newQuantity,
          'price': productDetail.price,
          'name': productDetail.name,
          'imageURL': productDetail.imageURL,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      // Update or set in the Orders collection similarly
      if (orderSnapshot.exists) {
        transaction.update(orderRef, {'quantity': newQuantity});
      } else {
        transaction.set(orderRef, {
          'productId': productId,
          'userId': userId,
          'quantity': newQuantity,
          'price': productDetail.price,
          'name': productDetail.name,
          'imageURL': productDetail.imageURL,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating cart and orders: $e');
    }
  });
}



  void removeProduct(String productId) async {
  if (!productQuantities.containsKey(productId) || productQuantities[productId]! <= 0) {
    print('Product quantity is already 0 or not in cart');
    return;
  }

  setState(() {
    productQuantities[productId] = productQuantities[productId]! - 1;
  });

  DocumentReference cartRef = FirebaseFirestore.instance.collection('carts').doc(productId);
  DocumentReference orderRef = FirebaseFirestore.instance.collection('Orders').doc(productId); // Reference to Orders collection

  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot cartSnapshot = await transaction.get(cartRef);
    // DocumentSnapshot orderSnapshot = await transaction.get(orderRef); // Get the current order snapshot

    if (cartSnapshot.exists && cartSnapshot['quantity'] > 1) {
      int newQuantity = cartSnapshot['quantity'] - 1;
      transaction.update(cartRef, {'quantity': newQuantity});
      transaction.update(orderRef, {'quantity': newQuantity}); // Update Orders collection
    } else {
      transaction.delete(cartRef);
      transaction.delete(orderRef); // Remove from Orders collection if quantity becomes 0
    }
  });
}



 double calculateTotalPrice() {
    double totalPrice = 0.0;
    productQuantities.forEach((productId, quantity) {
      double productPrice = getProductPrice(productId);
      totalPrice += productPrice * quantity;

      // Debug print
      print('Product ID: $productId, Quantity: $quantity, Subtotal: ${productPrice * quantity}');
    });
    return totalPrice;
  }




   double getProductPrice(String productId) {
        var product = products.firstWhere(
              (p) => p.id == productId,
              orElse: () => Product(id: '', category:'' ,name: '', price: 0.0, weight: 0.0, imageURL: ''), // Add default imageURL here
            );
        // Debug print
        print('Product ID: $productId, Price: ${product.price}');

        return product.price;
      }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Product>? products = snapshot.data;
              if (products != null && products.isNotEmpty) {
                return _buildProductCard(context, products);
              } else {
                return Center(child: Text('No products available'));
              }
            }
          },
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 54.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrow3,
        onTap: () {
          Navigator.pop(context);
        },
        margin: EdgeInsets.only(
          left: 22.h,
          top: 45.v,
          bottom: 28.v,
        ),
      ),
      title: AppbarTitle(
        text: widget.categoryName,
        margin: EdgeInsets.only(
          left: 30.h,
          top: 25.v,
          bottom: 4.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

Widget _buildProductCard(BuildContext context, List<Product> products) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Two items per row
      childAspectRatio: 3 / 5, // Adjust the size ratio of the card
      crossAxisSpacing: 10, // Space between cards horizontally
      mainAxisSpacing: 10, // Space between cards vertically
    ),
    itemCount: products.length,
    itemBuilder: (context, index) {
      Product product = products[index];
      int quantity = productQuantities[product.id] ?? 0;

      return Card(
        elevation: 4.0, // Gives a slight shadow to make the card pop a bit
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
              product.imageURL,
              fit: BoxFit.cover,
                       ),),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${product.price.toStringAsFixed(2)} | Weight: ${product.weight}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: () => removeProduct(product.id),
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () => addProduct(product.id),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}



  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Total Price: ₹${calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Cart Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartsPage()), // Assuming CartsPage exists
                );
              },
              child: Text('View Cart'),
            ),
          ],
        ),
      ),
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Heroiconssolidhome:
        return '/';
      case BottomBarEnum.Search:
        return '/';
      case BottomBarEnum.User:
        return '/';
      default:
        return '/';
    }
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Default Page'));
  }
}