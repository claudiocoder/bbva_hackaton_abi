import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class DataBaseService {

  final databaseReference = FirebaseDatabase.instance.reference();

  void createDataTokenAuth(phoneNumber, token) {
    databaseReference.child("Usuarios").push().set(
      {
        "PhoneNumber": phoneNumber,
        "token": token
      }
    );
  }
}