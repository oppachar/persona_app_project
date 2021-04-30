import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persona/screens/result/result_screen.dart';

import '../size_config.dart';
import '../constants.dart';
import 'home/home_screen.dart';
import 'mypage/mypage_screen.dart';

class BottomNavBar extends StatefulWidget {
  final User user;
  BottomNavBar(this.user);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _navitems = [
    {"icon": "assets/icons/home.svg", "title": "home"},
    {"icon": "assets/icons/result.svg", "title": "result"},
    {"icon": "assets/icons/mypage.svg", "title": "mypage"},
  ];

  List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(widget.user),
      ResultScreen(widget.user),
      MypageScreen(widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: kTextColor,
        selectedItemColor: kActiveColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        items: List.generate(
          _navitems.length,
          (index) => BottomNavigationBarItem(
            icon: buildSvgIcon(
                src: _navitems[index]['icon'],
                isActive: _selectedIndex == index,
                color: kTextColor),
            activeIcon: buildSvgIcon(
                src: _navitems[index]['icon'],
                isActive: _selectedIndex == index,
                color: kActiveColor),
            label: _navitems[index]["title"],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Image.asset(
        "assets/icons/logo.png",
      ),
      // actions: [
      //   if (_selectedIndex == 2)
      //     IconButton(
      //         icon: SvgPicture.asset("assets/icons/signout.svg"),
      //         color: kActiveColor,
      //         onPressed: () {
      //           showDialog(
      //               context: context,
      //               barrierDismissible: false,
      //               builder: (context) {
      //                 return CupertinoAlertDialog(
      //                   title: Text(
      //                     "로그아웃",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 15,
      //                     ),
      //                   ),
      //                   content: Text(
      //                     "정말 로그아웃 하시겠어요?",
      //                     style: TextStyle(fontSize: 13, height: 1.3),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                   actions: <Widget>[
      //                     new CupertinoDialogAction(
      //                         child: Text(
      //                           '아니오',
      //                           style: TextStyle(fontSize: 15),
      //                         ),
      //                         onPressed: () async {
      //                           Navigator.pop(context);
      //                         }),
      //                     new CupertinoDialogAction(
      //                         child: Text(
      //                           '예',
      //                           style: TextStyle(fontSize: 15),
      //                         ),
      //                         onPressed: () async {
      //                           // await FirebaseAuth.instance.signOut();
      //                           // Navigator.popUntil(
      //                           //     context, ModalRoute.withName('/root'));
      //                           // Navigator.push(
      //                           //     context,
      //                           //     MaterialPageRoute(
      //                           //         builder: (context) => RootPage()));
      //                         }),
      //                   ],
      //                 );
      //               });
      //         })
      // ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  SvgPicture buildSvgIcon(
      {@required String src, bool isActive = false, Color color}) {
    return SvgPicture.asset(
      src,
      height: 20,
      width: 20,
      color: color,
    );
  }
}
