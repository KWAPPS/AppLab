import 'package:flutter/material.dart';
import 'package:connect_app/utilities/custom_containers.dart';
import 'package:connect_app/screens/my_work.dart' as mywork;
import 'package:connect_app/screens/reviews.dart' as reviews;
import 'package:connect_app/screens/socials.dart' as socials;
import 'package:connect_app/utilities/constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.black54,
//                margin: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('images/avatar1.jpg'),
                          ),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cathy S',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Events Manager',
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileButton(
                          text: 'Hire me',
                          color: Color(0xffcc0e74),
                        ),
                        ProfileButton(
                          text: 'Follow',
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Color(0xffcc0e74),
                      controller: controller,
                      tabs: [
                        Tab(
                          text: 'My Work',
                        ),
                        Tab(
                          text: 'Reviews',
                        ),
                        Tab(
                          text: 'Socials',
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: controller,
                        children: [
                          mywork.MyWork(),
                          reviews.Reviews(),
                          socials.Socials()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
