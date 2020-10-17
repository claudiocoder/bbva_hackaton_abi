import 'package:flutter/material.dart';

class EncryptedMessage {
  String encryptedCredential;

  EncryptedMessage(String encryptedCredential) {
    this.encryptedCredential = encryptedCredential;
  }

  void set_encryptedCredential(String encryptedCredential) {
    this.encryptedCredential = encryptedCredential;
  }

  String get get_encryptedCredential {
    return encryptedCredential;
  }
}