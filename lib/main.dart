import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';
import 'package:vendeaze/presentation/products_page_screen/products_page_screen.dart';
 
class Sizer extends StatelessWidget {
  final Widget Function(BuildContext, Orientation, DeviceType) builder;

  const Sizer({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var orientation = mediaQueryData.orientation;
    var deviceType = getDeviceType(mediaQueryData);

    return builder(context, orientation, deviceType);
  }

  DeviceType getDeviceType(MediaQueryData mediaQueryData) {
    double deviceWidth = mediaQueryData.size.shortestSide;

    if (deviceWidth > 600) {
      return DeviceType.Tablet;
    } else {
      return DeviceType.Mobile;
    }
  }
}

enum DeviceType {
  Mobile,
  Tablet,
}

class ChangeTheme {
  static ThemeData getTheme(String color) {
    // Implement your theme change logic here based on the color parameter.
    // This is just a placeholder example.
    return ThemeData(
      primaryColor: color == 'primary' ? Colors.blue : Colors.green,
      // Add more theme properties as needed.
    );
  }
}


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        // Use the ChangeTheme class to get the theme based on your logic.
        var theme = ChangeTheme.getTheme('primary');

        return MaterialApp(
          theme: theme,
          title: 'vendeaze',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.landingPageScreen,
          routes: AppRoutes.routes,
        onGenerateRoute: (RouteSettings settings) {
    if (settings.name == AppRoutes.productsPageScreen) {
      final args = settings.arguments as Map<String, dynamic>; // Cast to Map<String, dynamic>
      final categoryName = args['categoryName'] as String; // Extract categoryName
      return MaterialPageRoute(
        builder: (context) => ProductsPageScreen(categoryName: categoryName),
      );
      }
        }
        );
      },
    );
  }
}