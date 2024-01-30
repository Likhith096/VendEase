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

class _ProductsPageScreenState extends State<ProductsPageScreen> {
  Map<String, int> productQuantities = {};
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProductsFromFirestore();
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    try {
      // Use a query to filter products based on the selected category
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('Category', isEqualTo: widget.categoryName)
          .get();
            print("Category: ${widget.categoryName}");
            print("Number of products found: ${querySnapshot.docs.length}");

      List<Product> products = querySnapshot.docs.map((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          String name = data['Name'] ?? '';
          double price = (data['Price'] ?? 0.0).toDouble();
          double weight = (data['Weight'] ?? 0.0).toDouble();

          return Product(
            name: name,
            price: price,
            weight: weight,
          );
        } else {
          throw Exception('Document data is null');
        }
      }).toList();

      return products;
    } catch (error) {
      print('Error fetching products: $error');
      return []; // Return an empty list if fetching fails
    }
  }


  void addProduct(String productId) {
    setState(() {
      if (productQuantities.containsKey(productId)) {
        productQuantities[productId] = productQuantities[productId]! + 1;
      } else {
        productQuantities[productId] = 1;
      }
    });
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    productQuantities.forEach((productId, quantity) {
      totalPrice += getProductPrice(productId) * quantity;
    });
    return totalPrice;
  }

  double getProductPrice(String productId) {
    // Implement logic to fetch price from productPrices map or backend
    // For now, we'll assume a hardcoded price
    return 10.0; // Replace with actual logic
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
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];
        return Card(
          child: ListTile(
            title: Text(product.name),
            subtitle: Text(
                '₹${product.price.toStringAsFixed(2)} | Weight: ${product.weight}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: productQuantities.containsKey(product.name) &&
                          productQuantities[product.name]! > 0
                      ? () => setState(() => productQuantities[product.name] =
                          productQuantities[product.name]! - 1)
                      : null,
                ),
                Text(productQuantities.containsKey(product.name)
                    ? productQuantities[product.name].toString()
                    : '0'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => addProduct(product.name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
          context,
          getCurrentRoute(type),
        );
      },
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
