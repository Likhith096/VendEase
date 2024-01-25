import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';

class CartsPage extends StatefulWidget {
  final Map<String, int> cartItems;

  const CartsPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartsPageState createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.white, // Placeholder for AppDecoration.fillPrimary
          child: Column(
            children: [
              Image.asset('assets/images/rectangle81.png', height: 55, width: 390), // Placeholder for CustomImageView
              SizedBox(height: 37),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Selected Products",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Placeholder for CustomTextStyles.bodyLargeKronaOne
                  ),
                ),
              ),
              SizedBox(height: 18),
              Expanded(child: _buildProductListSection(context)),
              _buildTopPicksSection(context),
              SizedBox(height: 49),
              _buildProceedToPaySection(context),
              SizedBox(height: 9),
            ],
          ),
        ),
      ),
    );
  }
  /// Section Widget
 Widget _buildProductListSection(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 9),
      itemCount: widget.cartItems.length, // Use the number of items in the cart
      itemBuilder: (context, index) {
        String productId = widget.cartItems.keys.elementAt(index);
        int quantity = widget.cartItems[productId]!;
        // Replace with actual implementation for your product list item widget
        return ListTile(
          title: Text(productId),
          subtitle: Text('Quantity: $quantity'),
          // Add more details and styling as needed
        );
      },
    );
  }

  /// Section Widget
   Widget _buildTopPicksSection(BuildContext context) {
    // Placeholder implementation for the top picks section
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Picks",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold), // Placeholder for theme.textTheme.bodyLarge
          ),
          SizedBox(height: 24),
          Container(
            height: 216,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 2, // Placeholder item count
separatorBuilder: (context, index) => SizedBox(width: 29),              itemBuilder: (context, index) => Container(
                width: 100, // Placeholder for product list item widget width
                color: Colors.blue, // Placeholder for product list item widget
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProceedToPaySection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 58.v,
            width: 101.h,
            padding: EdgeInsets.symmetric(
              horizontal: 29.h,
              vertical: 4.v,
            ),
            decoration: AppDecoration.outlineOnError2,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Bill",
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Bill",
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomElevatedButton(
              height: 58.v,
              text: "Proceed to Pay",
              buttonStyle: CustomButtonStyles.outlineOnError,
              buttonTextStyle: CustomTextStyles.headlineMedium28,
            ),
          ),
        ],
      ),
    );
  }
}
