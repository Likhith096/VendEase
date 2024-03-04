import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:vendeaze/presentation/carts_page/carts_page.dart';
import 'package:vendeaze/widgets/custom_bottom_bar.dart';
import '../products_page_screen/products_page_screen.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final PageController pageController = PageController(viewportFraction: 0.8);
 @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // This prevents the back button from doing anything
        // Return false to do nothing when back button is pressed
        return false;
      },
      child: SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLocationRow(context),
              SizedBox(height: 14.v),
              _buildCategoriesRow(context),
              Text(
                "CATEGORIES",
                style: CustomTextStyles.headlineLargePrimaryContainer,
              ),
              SizedBox(height: 55.v),
              _buildFacts(context),
              SizedBox(height: 30.v), // Replace Spacer with a SizedBox
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: _buildBottomBar(context),
        ),
      ),
      ),
    );
  }

Widget _buildFacts(BuildContext context) {
    final List<String> foodFacts = [
      "Fact 1: Eating fruits and vegetables can reduce the risk of chronic diseases.",
      "Fact 2: Whole grains are a great source of fiber and nutrients.",
      "Fact 3: Drinking water before meals can help with weight loss."
    ];

    return Container(
      height: 200.v, // Adjust height as needed
      child: PageView.builder(
        controller: pageController,
        itemCount: foodFacts.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double value = 1.0;
              if (pageController.position.haveDimensions) {
                value = pageController.page! - index;
                value = (1 - (value.abs() * .2)).clamp(0.8, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * 200.v,
                  width: Curves.easeInOut.transform(value) * 250.h,
                  child: child,
                ),
              );
            },
            child: Card(
              elevation: 4.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.h),
              ),
              child: Container(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      foodFacts[index],
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Add more content or styling as needed
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

   void _showLocationDialog(BuildContext context, String location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Coordinates'),
          content: Text(location),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }


  /// Section Widget
Widget _buildLocationRow(BuildContext context) {
  return FutureBuilder<String>(
    future: getCurrentLocation(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Correctly wrap the CircularProgressIndicator
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // Proper error handling
        return Text('Error: ${snapshot.error}');
      } else {
        // Display the location
        final location = snapshot.data;
        return SizedBox(
          // Correct dimensions and ensure your responsive design methods work
          height: 100, // Example size, adjust as needed
          width: 389, // Example size, adjust as needed
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 34),
                  // Ensure your decoration is correctly defined
                  decoration: AppDecoration.fillPink.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder40,
              ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ensure CustomImageView or equivalent is correctly implemented// Example replacement
                         Icon(Icons.location_on , size:40), 
                        GestureDetector(
                          onTap: () => _showLocationDialog(context, location!),
                          child: Text(
                            'Location',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Ensure CustomImageView or equivalent is correctly implemented
            CustomImageView(
            imagePath: ImageConstant.imgVendeaselogoRemovebgPreview164x255,
            height: 80.v,
            width: 136.h,
            alignment: Alignment.centerRight,
          ),
            ],
          ),
        );
      }
    },
  );
}

  /// Section Widget
Widget _buildCategoriesRow(BuildContext context) {
  // Updated list with category name and image path
  final List<Map<String, String>> categories = [
    {"name": "Snacks", "image": ImageConstant.imgCat1},
    {"name": "Chips", "image": ImageConstant.imgCat2},
    {"name": "Juices", "image": ImageConstant.imgCat3},
    {"name": "Mixtures", "image": ImageConstant.imgCat4},
    {"name": "Biscuits", "image": ImageConstant.imgCat5},
    // ... other categories
  ];

  return Container(
    height: 324.v, // Set a fixed height for the container
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 31.h : 55.h,
            right: index == categories.length - 1 ? 31.h : 0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsPageScreen(
                    // Pass the selected category name to the ProductsPageScreen
                    categoryName: categories[index]["name"]!,
                  ),
                ),
              );
            },
            child: CustomImageView(
              imagePath: categories[index]["image"]!,
              height: 324.v,
              width: 280.h,
              radius: BorderRadius.circular(24.h),
            ),
          ),
        );
      },
    ),
  );
}


/// Section Widget
Widget _buildBottomBar(BuildContext context) {
  return CustomBottomBar(
    currentPage: BottomBarEnum.Heroiconssolidhome, // Example for the home page
    onChanged: (BottomBarEnum type) {
      // This callback can be used to update the state of HomeScreen if needed.
    },
  );
}


Future<String> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return "Location service disabled";
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return "Location permission denied";
    }
  }

  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return "${position.latitude}, ${position.longitude}";
  } catch (e) {
    return "Error getting location: $e";
  }
}


/// Handling page based on route
Widget getCurrentPage(String currentRoute) {
  switch (currentRoute) {
    case AppRoutes.cartsPage:
      return CartsPage();
    default:
      return HomeScreen();
  }
}

}
