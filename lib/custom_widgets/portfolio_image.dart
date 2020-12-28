import 'package:flutter/material.dart';

class PortfolioImage extends StatelessWidget {
  PortfolioImage({@required this.assetImagePath});

  final String assetImagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: 200,
        child: ClipRRect(
          child: Image(image: AssetImage(assetImagePath)),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
