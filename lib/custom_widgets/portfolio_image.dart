import 'package:connect_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PortfolioImage extends StatelessWidget {
  PortfolioImage({@required this.networkImageURL});

  final String networkImageURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: kLightBlue2,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        width: MediaQuery.of(context).size.width * 0.43,
        child: ClipRRect(
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, image: networkImageURL),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
