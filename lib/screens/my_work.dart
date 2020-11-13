import 'package:flutter/material.dart';
import 'package:connect_app/custom_widgets/portfolio_image.dart';

class MyWork extends StatefulWidget {
  @override
  _MyWorkState createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      PortfolioImage(
                        assetImagePath: 'images/portfolio1.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio2.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio4.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio6.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio1.jpg',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      PortfolioImage(
                        assetImagePath: 'images/portfolio7.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio5.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio7.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio2.jpg',
                      ),
                      PortfolioImage(
                        assetImagePath: 'images/portfolio1.jpg',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
