import 'package:flutter/material.dart';

class ProductPopup extends StatefulWidget {
  final List<String> addedProducts;
  final VoidCallback onClose;

  ProductPopup({required this.addedProducts, required this.onClose});

  @override
  _ProductPopupState createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  @override
  Widget build(BuildContext context) {
    // Removed Positioned widget and used Container directly
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Make the column's height fit its children
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Added Products:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          // Display added products
          ListView.builder(
            shrinkWrap: true, // Needed to make ListView work inside Column
            itemCount: widget.addedProducts.length,
            itemBuilder: (context, index) {
              return Text(widget.addedProducts[index]);
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Navigate to view cart page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewCartPage()),
              );
            },
            child: Text('View Cart'),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: widget.onClose, // Close the popup
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class ViewCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Cart'),
      ),
      body: Center(
        child: Text('View Cart Page Content'),
      ),
    );
  }
}