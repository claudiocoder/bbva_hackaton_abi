import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/services/authService.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';

class PictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child:
          RaisedButton(
            onPressed: () {
              AuthService().signOut();
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Login()),
              );
            },
            child: Text("verify",
              style: TextStyle(color: Colors.white),),
            elevation: 7.0,
            color: Colors.blue
      ),
    );
  }
}
