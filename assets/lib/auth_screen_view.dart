import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_anywhere/login.dart';
import 'package:movies_anywhere/signup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreenView extends StatefulWidget {
  @override
  _AuthScreenViewState createState() => _AuthScreenViewState();
}

class _AuthScreenViewState extends State<AuthScreenView> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    //pageController.jumpToPage(pageIndex);
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          //when pageIndex == 0
          LoginPage(),

          //when pageIndex == 1
          RegisterPage()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("Log-In"),
              icon: Icon(
                FontAwesomeIcons.signInAlt,
              )),
          BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("Register"),
              icon: Icon(
                FontAwesomeIcons.userPlus,
              )),
        ],
      ),
    );
  }
}
