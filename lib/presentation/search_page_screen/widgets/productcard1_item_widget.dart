import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/models/product_model.dart';
class ProductCardItemWidget extends StatelessWidget {
  final Product product;

  ProductCardItemWidget({Key? key, required this.product}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () {
        // Navigate to the Products Page for the selected category
        Navigator.pushNamed(
          context,
          AppRoutes.productsPageScreen, // Ensure this route name is correct
          arguments: {'categoryName': product.category}, // Passing the selected category as an argument
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the product image if available
            if (product.imageURL.isNotEmpty)
              Image.network(
                product.imageURL,
                height: 150,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 8),
            // Display the product name
            Text(
              'Category: ' + product.category,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Display the product price
            Text(
              '₹${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 8),
            // Display the product weight
            Text(
              '${product.weight.toString()}g',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ),
  );
}

}