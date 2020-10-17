import 'dart:convert';

import 'package:flutter/material.dart';

class Auth {
  String encryptedCredential;

  Auth({
    @required String encryptedCredential
  });

  void set set_encryptedCredential(String encryptedCredential) {
    this.encryptedCredential = encryptedCredential;
  }

  String get get_encryptedCredential {
    return encryptedCredential;
  }

  String get get_as_json {
    return jsonEncode({ 'encryptedCredential': this.encryptedCredential });
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      encryptedCredential: json['encryptedCredential'] as String
    );
  }
}