import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:international_phone_input/international_phone_input.dart';

import '../splash.dart';


class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _LoginState extends State<Login> {

  var _controller = TextEditingController();
  String phoneNo, smssent, verificationId;

  get verifiedSuccess => null;

  Future<void> verfiyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      print(verId);
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent= (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value){
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess= (AuthCredential auth){};


    final PhoneVerificationFailed verifyFailed= ( e){
      print('${e.message}');
    };


    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted : verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,

    );

  }
  Future<bool> smsCodeDialoge(BuildContext context){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text('Enter OTP'),
            content: TextField(
              onChanged: (value){
                this.smssent = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  // FirebaseAuth.instance.currentUser().then((user){
                  //   if(user != null){
                  //     Navigator.of(context).pop();
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context)=> Login()),
                  //     );
                  //
                  //   }
                  //   else{
                  //     Navigator.of(context).pop();
                  //     signIn(smssent);
                  //   }
                  // });
                },
                child: Text('done',
                  style:TextStyle(color: Colors.white) ,),
              ),
            ],

          );
        }
    );
  }
  Future<void> signIn(String smsCode) async{
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,);

    await FirebaseAuth.instance.signInWithCredential(
        credential).then((user) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Login()),
      );
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Equipo Knikfall'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "telefono",
              ),
              onChanged: (value){
                this.phoneNo= value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: verfiyPhone,
            child: Text("verify",
              style: TextStyle(color: Colors.white),),
            elevation: 7.0,
            color: Colors.blue,
          )
        ],
      ),

    );
  }
}
