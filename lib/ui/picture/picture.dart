import 'package:flutter/material.dart';

class PictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Text(
          'Aqui tomaremos la foto',
        ),
      ),
    );
  }
}
