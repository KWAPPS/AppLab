import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/custom_widgets/search_bar.dart';
import 'package:connect_app/custom_widgets/person_info_card.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

ScrollController _scrollSearchBarController;
bool isScrollingDown = false;
bool _show = true;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation colorAnimation;

  void showBottomBar() async {
    setState(() {
      _show = true;
      animationController.reverse();
    });
  }

  void hideBottomBar() async {
    setState(() {
      _show = false;
      animationController.forward();
    });
  }

  void scroll() async {
    print('scroll method called');
    _scrollSearchBarController.addListener(() {
      if (_scrollSearchBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print('scroll is reverse');
        if (!isScrollingDown) {
          isScrollingDown = true;
          _show = false;
          hideBottomBar();
        }
      }
      if (_scrollSearchBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print('scroll is forward');
        if (isScrollingDown) {
          isScrollingDown = false;
          _show = true;
          showBottomBar();
        }
      }
    });
  }

  @override
  void initState() {
    _show = true;
    _scrollSearchBarController = ScrollController();
    scroll();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    colorAnimation =
        Tween<double>(begin: 100, end: 500).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kDarkPurple, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    super.initState();
  }

  @override
  void dispose() {
    _scrollSearchBarController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: kDarkPurple,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollSearchBarController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Results for "hair stylist">',
                        style: kSmallHeadingStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: _show == true
                    ? SearchBar(
                        colour: Colors.white,
                      )
                    : null,
              )
            ],
          )),
    );
  }
}
