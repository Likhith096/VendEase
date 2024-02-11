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
import 'package:vendeaze/presentation/profile_screen/profile_screen.dart';
import 'package:vendeaze/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:vendeaze/presentation/confirmed_screen/confirmed_screen.dart';
import 'package:vendeaze/presentation/payment_card_screen/payment_card_screen.dart';
import 'package:vendeaze/presentation/payment_screen/payment_screen.dart';
import 'package:vendeaze/presentation/orders_history/orders_history.dart';
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

  static const String profileScreen = '/profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String paymentScreen = '/payment_screen';

  static const String confirmedScreen = '/confirmed_screen';

  static const String paymentCardScreen = '/payment_card_screen';

  static const String orderHistoryScreen = '/orders_history';

  static Map<String, WidgetBuilder> routes = {
    landingPageScreen: (context) => LandingPageScreen(),
    loginSignupScreen: (context) => LoginSignupScreen(),
    loginScreen: (context) => LoginScreen(),
    signUpScreen: (context) => SignUpScreen(),
    frameElevenScreen: (context) => FrameElevenScreen(),
    AppRoutes.productsPageScreen: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
    final categoryName = args['categoryName'] as String? ?? 'Default Category'; // Provide a default or handle null as needed
    return ProductsPageScreen(categoryName: categoryName);
  },
    searchPageScreen: (context) => SearchPageScreen(),
    cartsPageContainerScreen: (context) => CartsPageContainerScreen(),
    homeScreen: (context) => HomeScreen(),
    profileScreen: (context) => ProfileScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    paymentScreen: (context) => PaymentScreen(),
    confirmedScreen: (context) => ConfirmedScreen(),
    paymentCardScreen: (context) => PaymentCardScreen(),
    orderHistoryScreen: (context) => OrderHistoryScreen(),
  };
}
