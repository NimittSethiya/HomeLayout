import 'package:flutter/material.dart';
import 'package:flutter_task/Search.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  var acceptedData;
  var profileImages;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _bottomNavBar()
    );
  }

  _bottomNavBar() {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: [
          Search(),
          Search(),
          Search(),
          Search(),
          Search(),

        ],
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
    curve: Curves.ease,
    ),
    screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
    animateTabTransition: true,
    curve: Curves.ease,
    duration: Duration(milliseconds: 200),
    ),
    navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        iconSize: 25,
        title: ("Search"),
        activeColor: Colors.greenAccent,
        inactiveColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        iconSize: 25,
        title: ("Connection"),
        activeColor: Colors.greenAccent,
        inactiveColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.star_border_rounded),
        iconSize: 25,
        title: ("Experiences"),
        activeColor: Colors.greenAccent,
        inactiveColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_today_outlined),
        iconSize: 25,
        title: ("Dates"),
        activeColor: Colors.greenAccent,
        inactiveColor: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline),
        iconSize: 25,
        title: ("Dashboard"),
        activeColor: Colors.greenAccent,
        inactiveColor: Colors.black,
      ),

    ];
  }

}
