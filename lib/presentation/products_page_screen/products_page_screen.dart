import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
// import 'package:vendeaze/presentation/carts_page/carts_page.dart';
import 'package:vendeaze/widgets/app_bar/appbar_leading_image.dart';
import 'package:vendeaze/widgets/app_bar/appbar_title.dart';
import 'package:vendeaze/widgets/app_bar/custom_app_bar.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';
import '../carts_page/carts_page.dart';

class ProductsPageScreen extends StatefulWidget {
  final String categoryName;

  ProductsPageScreen({Key? key, required this.categoryName}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _ProductsPageScreenState createState() => _ProductsPageScreenState();
}

class _ProductsPageScreenState extends State<ProductsPageScreen> {
  Map<String, int> productQuantities = {};

  // Example product prices (you might want to fetch these from a database or API)
  Map<String, double> productPrices = {
    'Product1': 10.0,
    'Product2': 15.0,
    // Add more products as needed
  };

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
      double price = productPrices[productId] ?? 0.0;
      totalPrice += price * quantity;
    });
    return totalPrice;
  }

@override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: _buildProductCard(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Price: ₹${totalPrice.toStringAsFixed(2)}'),
        ElevatedButton(
  onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CartsPage(cartItems: productQuantities),
    ));
  },
  child: Text('View Cart'),
),
                ],
              ),
            ),
          ],
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

  Widget _buildProductCard(BuildContext context) {
    // Assuming you have a list of product IDs
    List<String> productIds = ['Product1', 'Product2']; // Populate with your actual product IDs

    return ListView.builder(
      itemCount: productIds.length,
      itemBuilder: (context, index) {
        String productId = productIds[index];
        return Card(
          child: ListTile(
            title: Text(productId),
            subtitle: Text('₹${productPrices[productId]?.toStringAsFixed(2) ?? '0.00'}'),            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: productQuantities[productId] != null && productQuantities[productId]! > 0
                      ? () => setState(() => productQuantities[productId] = productQuantities[productId]! - 1)
                      : null,
                ),
                Text(productQuantities[productId]?.toString() ?? '0'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => addProduct(productId),
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
        // Navigate to home
        return '/';
      case BottomBarEnum.Search:
        // Navigate to search
        return '/';
      case BottomBarEnum.User:
        // Navigate to user profile or settings
        return '/';
      // case BottomBarEnum.Cart:
      //   // Navigate to cart page
      //   return AppRoutes.cartsPage;
      default:
        // Default navigation
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