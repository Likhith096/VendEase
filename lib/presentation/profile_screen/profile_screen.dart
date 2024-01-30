import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = ''; // Variable to store the user's name
  String _phoneNumber = ''; // Variable for phone number
  String _email = '';       // Variable for email


  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchContactInfo();
  }

  Future<void> _fetchUserName() async {
    // Call your backend API to fetch the user's name
    // Example:
    // String userName = await BackendService.fetchUserName();
    // setState(() {
    //   _userName = userName;
    // });
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // User is signed in, userId contains the UID
      print('User ID: $userId');
    } else {
      // No user is signed in
      print('No user signed in');
    }
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    // if (userSnapshot.exists) {
      // Cast the data to Map<String, dynamic>
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      
      // Access the user's name property from the userData map
      String username = userData['name'];
      // Use the fetched username in your app
    // }
        
    // String userName = "Bhupendra Jogi";
    setState(() {
      _userName = username;
    });
  }

     Future<void> _fetchContactInfo() async {
    // Fetch and set the contact information from your backend or Firebase
    // Example:
    // _phoneNumber = await BackendService.fetchPhoneNumber();
    // _email = await BackendService.fetchEmail();
    setState(() {
      _phoneNumber = '123-456-7890'; // Example phone number
      _email = 'info@example.com';   // Example email
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.pink100,
        body: SingleChildScrollView(
          child: SizedBox(
            height: SizeUtils.height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 55.v),
                    decoration: AppDecoration.fillPrimary.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder64,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_userName, style: theme.textTheme.displaySmall),
                        SizedBox(height: 101.v),
                        _buildProfileSection(context),
                        SizedBox(height: 101.v),
                      ],
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.img31357151,
                  height: 144.v,
                  width: 140.h,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 75.v),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgVendeaselogoRemovebgPreview88x131,
                  height: 88.v,
                  width: 131.h,
                  alignment: Alignment.topRight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   width: double.maxFinite,
        //   padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 1.v),
        //   decoration: AppDecoration.fillPrimary.copyWith(
        //     borderRadius: BorderRadiusStyle.roundedBorder10,
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(height: 22.v),
        //       Text("My Orders", style: theme.textTheme.headlineLarge),
        //     ],
        //   ),
        // ),
        SizedBox(height: 18.v),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 9.v),
          decoration: AppDecoration.fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.v),
              Text("About", style: theme.textTheme.headlineLarge),
            ],
          ),
        ),
        SizedBox(height: 17.v),
        _buildContactUsSection(),
        // Container(
        //   width: double.maxFinite,
        //   padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 12.v),
        //   decoration: AppDecoration.fillPrimary.copyWith(
        //     borderRadius: BorderRadiusStyle.roundedBorder10,
        //   ),
        //   child: Text("Contact Us", style: theme.textTheme.headlineLarge),
        // ),
        SizedBox(height: 16.v),
        GestureDetector(
          onTap: () {
            onTapLogout(context);
          },
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.v),
            decoration: AppDecoration.fillPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.v),
                Text("Logout", style: theme.textTheme.headlineLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }

   Widget _buildContactUsSection() {
    return GestureDetector(
      onTap: () {
        // Show phone number and email in a dialog or another widget
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Contact Us"),
              content: Text("Phone: $_phoneNumber\nEmail: $_email"),
              actions: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 9.v),
        decoration: AppDecoration.fillPrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.v),
            Text("Contact Us", style: theme.textTheme.headlineLarge),
          ],
        ),
      ),
    );
  }

  /// Navigates to the loginSignupScreen when the action is triggered.
  onTapLogout(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginSignupScreen);
  }
}
