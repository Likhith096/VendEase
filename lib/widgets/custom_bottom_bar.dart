import 'package:flutter/material.dart';
import 'package:vendeaze/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  final Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHeroiconsSolidHome,
      activeIcon: ImageConstant.imgHeroiconsSolidHome,
      type: BottomBarEnum.Heroiconssolidhome,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSearch,
      activeIcon: ImageConstant.imgSearch,
      type: BottomBarEnum.Search,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUser,
      activeIcon: ImageConstant.imgUser,
      type: BottomBarEnum.User,
    )
  ];

  @override
Widget build(BuildContext context) {
    return SizedBox(
        height: 54.v,
        child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(0, 25, 215, 25),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
                return BottomNavigationBarItem(
                    icon: CustomImageView(
                        imagePath: bottomMenuList[index].icon,
                        height: 36.adaptSize,
                        width: 36.adaptSize,
                        color: selectedIndex == index
                            ? Colors.red // Change color for selected icon
                            : theme.colorScheme.onBackground, // Color for unselected icon
                    ),
                    activeIcon: CustomImageView(
                        imagePath: bottomMenuList[index].activeIcon,
                        height: 36.adaptSize,
                        width: 36.adaptSize,
                        color: Colors.red, // Set active icon color to red
                    ),
                    label: '',
                );
            }),
            onTap: (index) {
                setState(() {
                    selectedIndex = index;
                });
                Navigator.pushNamed(context, getCurrentRoute(bottomMenuList[index].type));  
            },
        ),
    );
}

}

/// Handling route based on bottom click actions
String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
    case BottomBarEnum.Heroiconssolidhome:
      return AppRoutes.homeScreen; // Corrected route for Home
    case BottomBarEnum.Search:
      return AppRoutes.searchPageScreen;
    case BottomBarEnum.User:
      return AppRoutes.profileScreen;
    default:
      return "/";
  }
}

enum BottomBarEnum {
  Heroiconssolidhome,
  Search,
  User,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 212, 18, 18),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
