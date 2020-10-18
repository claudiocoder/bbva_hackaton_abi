import 'package:flutter/material.dart';
class  CardImage extends StatelessWidget {

  String pathImage = "assets/images/happy.jpg";

  CardImage(this.pathImage);

  @override
  Widget build(BuildContext context) {

    final card = Container(
      height: 150.0,
      width: 150.0,
      margin: EdgeInsets.only(
        top: 30.0,
        left: 0.0
      ),

      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
            image: AssetImage(pathImage)
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );

    return Stack(
      alignment: Alignment(0.9,1.1),
      children: <Widget>[
        card,
      ],
    );
  }

}