import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/widgets/custom_elevated_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


// This page has Razor pay APi called via constructor itself 
// and Confirmation page.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

Razorpay? _razorpay;

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
      'amount' : 1000, //In Paisa
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.purple50,
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 28.v),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                    CustomElevatedButton(
                      text: "Vend",
                      margin: EdgeInsets.only(left: 18.h, right: 19.h),
                      onPressed: (){
                        //
                      }),
                  SizedBox(height: 51.v),

                  CustomElevatedButton(
                      text: "View Orders",
                      margin: EdgeInsets.only(left: 18.h, right: 19.h),
                      onPressed: (){
                        ontap(context);
                      }),
                  SizedBox(height: 51.v)
                ]))));
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
