import 'package:flutter/material.dart';
import 'package:vendeaze/presentation/landing_page_screen/landing_page_screen.dart';
import 'package:vendeaze/presentation/login_signup_screen/login_signup_screen.dart';
import 'package:vendeaze/presentation/login_screen/login_screen.dart';
import 'package:vendeaze/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:vendeaze/presentation/frame_eleven_screen/frame_eleven_screen.dart';
import 'package:vendeaze/presentation/products_page_screen/products_page_screen.dart';
import 'package:vendeaze/presentation/search_page_screen/search_page_screen.dart';
import 'package:vendeaze/presentation/carts_page_container_screen/carts_page_container_screen.dart';
import 'package:vendeaze/presentation/home_screen/home_screen.dart';
import 'package:vendeaze/presentation/home_with_cart_screen/home_with_cart_screen.dart';
import 'package:vendeaze/presentation/profile_screen/profile_screen.dart';
import 'package:vendeaze/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String landingPageScreen = '/landing_page_screen';

  static const String loginSignupScreen = '/login_signup_screen';

  static const String loginScreen = '/login_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String frameElevenScreen = '/frame_eleven_screen';

  static const String productsPageScreen = '/products_page_screen';

  static const String searchPageScreen = '/search_page_screen';

  static const String cartsPage = '/carts_page';

  static const String cartsPageContainerScreen = '/carts_page_container_screen';

  static const String homeScreen = '/home_screen';

  static const String homeWithCartScreen = '/home_with_cart_screen';

  static const String profileScreen = '/profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    landingPageScreen: (context) => LandingPageScreen(),
    loginSignupScreen: (context) => LoginSignupScreen(),
    loginScreen: (context) => LoginScreen(),
    signUpScreen: (context) => SignUpScreen(),
    frameElevenScreen: (context) => FrameElevenScreen(),
    productsPageScreen: (context) => ProductsPageScreen(),
    searchPageScreen: (context) => SearchPageScreen(),
    cartsPageContainerScreen: (context) => CartsPageContainerScreen(),
    homeScreen: (context) => HomeScreen(),
    homeWithCartScreen: (context) => HomeWithCartScreen(),
    profileScreen: (context) => ProfileScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
