import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackaton_bbva_abi/services/authService.dart';
import 'dart:ui';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNo, smssent, verificationId;

  get verifiedSuccess => null;

  Future<void> verfiyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      print(verId);
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      AuthService().signIn(auth);
    };

    final PhoneVerificationFailed verifyFailed = (e) {
      print('${e.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 120),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Ingresa código de seguridad', textAlign: TextAlign.left,),
            content: TextField(
              onChanged: (value) {
                this.smssent = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  AuthService().signInWithOTP(smssent, verificationId, phoneNo);
                },
                child: Text(
                  'Listo',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Text(
              "Bienvenido a ABI",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20.0),
            child: TextField(
              style: TextStyle(
                fontSize: 25.0,
                height: 2.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  hintText: 'Ingresa tu número celular',
                  fillColor: Colors.white38),
              onChanged: (value) {
                this.phoneNo = value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),
          MaterialButton(
            height: 58,
            minWidth: 340,
            color: Color(0xFF14549C),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(12),
            ),
            onPressed: verfiyPhone,
            child: Text(
              "Registrar",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
