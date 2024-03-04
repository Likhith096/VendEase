import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// This page has Razor pay APi called via constructor itself 
// and Confirmation page i.e Carts Page without Add and Remove of products.
// This also has a Vend Button

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


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

Razorpay? _razorpay;
final int totalPrice=0;

  void _handlePaymentSuccess(PaymentSuccessResponse res)
  {
    Fluttertoast.showToast(  msg: "Payment Successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green ,
        textColor: Colors.white,
        fontSize: 16.0,);
  }

  void _handlePaymentError(PaymentFailureResponse res)
  {
      Fluttertoast.showToast(  msg: "Payment Failure!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red ,
        textColor: Colors.white,
        fontSize: 16.0,);
  }

  void makePayment() async{
    var options = {
      'key' : 'rzp_test_gPBGCagUrvEgTY',
      'amount' : 8000, //In Paisa
      'name' : "Likhith",
      'description' : "Chips",
      'prefill' : {'contact': "8660486877" , 'email' : "likhith.cs21@bmsce.ac.in"},
    };

  try{
    _razorpay?.open(options);
  }
  catch(e){
    debugPrint(e.toString());
  }
  }

  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) { //Calls as soon as Widget tree is built
    makePayment();
    });
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR , _handlePaymentError);
  }

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

  Future<void> vendItemsAndNavigateHome(BuildContext context, String userId) async {
  // Fetch cart items for the user
  final QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
      .collection('carts')
      .where('userId', isEqualTo: userId)
      .get();

  // Add cart items to orderHistory collection
  for (var doc in cartSnapshot.docs) {
    await FirebaseFirestore.instance.collection('orderHistory').add({
      ...doc.data() as Map<String, dynamic>,
      'vendedOn': FieldValue.serverTimestamp(), // Optional: Add a timestamp for when the item was vended
    });
  }

  // Delete cart items
  for (var doc in cartSnapshot.docs) {
    await FirebaseFirestore.instance.collection('carts').doc(doc.id).delete();
  }

  // Navigate to home page
  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (Route<dynamic> route) => false);
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
            }
              return Column(
                children: [
                  // Light pink header with "Cart"
                  Container(
                    width: double.infinity,
                    color: Colors.pink[100], // Light pink color
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Text(
                      "Vending",
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

                    CustomElevatedButton(
                      text: "Vend",
                      margin: EdgeInsets.only(left: 18.h, right: 19.h),
                      onPressed: () async {
                        await vendItemsAndNavigateHome(context, userId);
                      },
                    ),
                  SizedBox(height: 51.v),
                ],
              );
            },
        )));
        }

void ontap(BuildContext context)
  {
     Navigator.pushNamed(context,AppRoutes.orderHistoryScreen);
  }
  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
