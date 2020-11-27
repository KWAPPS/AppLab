// import 'package:flutter/material.dart';
// import 'package:connect_app/screens/in_app/home_screen.dart';
// import 'package:connect_app/screens/in_app/search_screen.dart';
// import 'package:connect_app/screens/in_app/profile_screen.dart';
// import 'package:connect_app/screens/in_app/upload_screen.dart';
// import 'package:flutter/cupertino.dart';
//
// class HomeTest extends StatefulWidget {
//   @override
//   _HomeTestState createState() => _HomeTestState();
// }
//
// class _HomeTestState extends State<HomeTest> {
//   PageController pageController;
//   int pageIndex = 0;
//   @override
//   void initState() {
//     pageController = PageController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
//
//   onPageChanged(int pageIndex) {
//     setState(() {
//       this.pageIndex = pageIndex;
//     });
//   }
//
//   onTap(int pageIndex) {
//     pageController.jumpToPage(
//       pageIndex,
//     );
//   }
//
//   Scaffold bottomBar() {
//     return Scaffold(
//       body: PageView(
//         children: [
//           HomeScreen(),
//           UploadScreen(),
//           SearchScreen(),
//           ProfileScreen(),
//         ],
//         controller: pageController,
//         onPageChanged: onPageChanged,
//         physics: NeverScrollableScrollPhysics(),
//       ),
//       bottomNavigationBar: CupertinoTabBar(
//         currentIndex: pageIndex,
//         onTap: onTap,
//         activeColor: Colors.pinkAccent,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.whatshot),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.photo_camera),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return bottomBar();
//   }
// }
