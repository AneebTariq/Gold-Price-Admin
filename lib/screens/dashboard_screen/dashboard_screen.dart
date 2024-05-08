import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/image_assets.dart';
import '../home_screen/home_screen.dart';
import '../jewelry_screen/jewelry_screen.dart';

class DasBoardScreen extends StatefulWidget {
  const DasBoardScreen({super.key});

  @override
  State<DasBoardScreen> createState() => _DasBoardScreenState();
}

class _DasBoardScreenState extends State<DasBoardScreen> {
  int currentIndex = 0;

  final List<Widget> children = [
    HomeScreen(),
    JewelryScreen(),
  ];

  Widget getSelectedScreen() {
    switch (currentIndex) {
      case 0:
        return  HomeScreen();
      case 1:
        return   JewelryScreen();
      default:
        return const Center(child: Text('Coming Soon...'));
    }
  }
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getSelectedScreen(),
        bottomNavigationBar:  BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.unSelectedClr,
          onTap: onTabSelected,
          currentIndex: currentIndex,
          backgroundColor: AppColors.black,
          items:  [
            BottomNavigationBarItem(
              activeIcon: Image(
                height: 18.h,
                image: const AssetImage(ImageAssets.homeIcon),
                color: AppColors.primaryColor,
              ),
              icon: Image(
                height: 18.h,
                image:  const AssetImage(ImageAssets.homeIcon),
                color: AppColors.unSelectedClr,
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: Image(
                height: 20.h,
                image: const AssetImage(ImageAssets.jewelryIcon),
                color: AppColors.primaryColor,
              ),
              icon: Image(
                height: 20.h,
                image: const  AssetImage(ImageAssets.jewelryIcon),
                color: AppColors.unSelectedClr,
              ),
              label: 'jewelry'.tr,
            ),
    ]),
    );
  }
}

