import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
          backgroundColor: Colors.blue, // Customize your AppBar
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('orders') // Assuming 'orders' is your collection name
              .where('userId', isEqualTo: userId)
              .orderBy('date', descending: true) // Assuming you store a 'date' field in each order
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching orders'));
            } else if (snapshot.data?.docs.isEmpty ?? true) {
              return Center(child: Text('No orders found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final order = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  // Formatting date for display, assuming 'date' is a Timestamp
                  final DateTime orderDate = (order['date'] as Timestamp).toDate();
                  final String formattedDate = DateFormat('dd MMM, yyyy').format(orderDate);

                  return ListTile(
                    title: Text('Order ID: ${snapshot.data!.docs[index].id}'),
                    subtitle: Text('Date: $formattedDate - Total: \$${order['total']}'),
                    // Add onTap or other widgets as needed, e.g., to view order details
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
