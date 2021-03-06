import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';
import 'package:hackaton_bbva_abi/ui/splash.dart';

import 'notification.dart';

class AuthService {
  String phoneNumber;

  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return SplashScreen();
          } else {
            return Login();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId, phoneNumber) {
    this.phoneNumber = phoneNumber;
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);

    PushNotificationsManager().initFireMessaging(phoneNumber);
    signIn(authCreds);
  }
}
