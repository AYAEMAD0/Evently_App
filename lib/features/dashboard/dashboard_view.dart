import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:evently_app/features/dashboard/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/routing/routes.dart';
import 'tabs/fav/fav_tab.dart';
import 'tabs/home/view/home_tab.dart';
import 'tabs/map/map_tab.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {


  int selectedIndex = 0;

  final List<IconData> iconSelected = [
    Icons.home,
    Icons.location_on,
    Icons.favorite,
    Icons.person,
  ];

  final List<IconData> iconUnselected = [
    Icons.home_outlined,
    Icons.location_on_outlined,
    Icons.favorite_outline,
    Icons.person_outline,
  ];

  final List tabList = [HomeTab(), MapTab(), FavTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconSelected.length,
        borderColor: Theme.of(context).cardColor,
        borderWidth: 3.w,
        backgroundColor: Theme.of(context).canvasColor,
        activeIndex: selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 25.r,
        rightCornerRadius: 25.r,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        tabBuilder: (index, active) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 3.w,
            ),
            child: Column(
              children: [
                Icon(
                  active ? iconSelected[index] : iconUnselected[index],
                  size: 30.h,
                  color: Theme.of(context).cardColor,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo add event
          Navigator.pushNamed(context, Routes.addEventRouteName);
        },
        shape: StadiumBorder(
          side: BorderSide(color: Theme.of(context).cardColor, width: 3.w),
        ),
        child: Icon(Icons.add, size: 33.h),
      ),
      body: tabList[selectedIndex],
    );
  }
}
