import 'package:flutter/material.dart';
import 'package:connect_app/utilities/constants.dart';
import 'package:connect_app/custom_widgets/star.dart';
import 'package:connect_app/custom_widgets/hire_me_button.dart';
import 'package:connect_app/screens/in_app/profile_screen.dart';

class PeopleCard extends StatelessWidget {
  final String descriptiveText;
  final String imageURL;
  final String name;
  final String occupation;

  PeopleCard({this.descriptiveText, this.imageURL, this.name, this.occupation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        elevation: 3,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              color: kDarkBlue2,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(imageURL),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [Star(), Star(), Star(), Star()],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            occupation,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                color: kLightPurple),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      color: kLightPurple,
                      height: 1,
                      width: 200,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 180,
                      child: Text(
                        descriptiveText,
                        style: TextStyle(fontFamily: 'Nunito'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  HireMeButton(
                    buttonColor: kLightBlue2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PeopleCard2 extends StatelessWidget {
  final String imageURL;
  final String name;
  final String occupation;

  PeopleCard2(
      {this.imageURL = 'images/portfolio2.jpg',
      this.name = 'Michael Okoth',
      this.occupation = 'photographer'});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      },
      child: Container(
        child: Column(
          children: [
            Container(
              height: 90,
              width: 150,
              child: Text(
                '.',
                style: TextStyle(fontSize: 1),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(imageURL), fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: 100,
                color: Colors.white,
                height: 1,
              ),
            ),
            Text(
              occupation,
              style: TextStyle(
                  fontFamily: 'Nunito',
                  color: kLightPurple,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [Star(), Star(), Star(), Star()],
            )
          ],
        ),
        height: 190,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
