import 'dart:convert';
import 'dart:typed_data';

import 'package:hackaton_bbva_abi/crypto/algorithms/cipher.dart';
import 'package:hackaton_bbva_abi/crypto/model/public_key.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';

class Rsa implements Cipher {
  String message;
  AsymetricPublicKey publicKey;

  Rsa(AsymetricPublicKey publicKey) {
    this.publicKey = publicKey;
  }

  void set_message(String message) {
    this.message = message;
  }

  String get get_message {
    return this.message;
  }

  void set_public_key(AsymetricPublicKey public_key) {
    this.publicKey = public_key;
  }

  AsymetricPublicKey get get_public_key {
    return this.publicKey;
  }

  @override
  String encrypt() {
    var cipher = PKCS1Encoding(RSAEngine());
    cipher.init(
        true,
        PublicKeyParameter<RSAPublicKey>(
            this.get_public_key.to_rsa_public_key()));
    Uint8List encryptedBytes = cipher.process(utf8.encode(this.get_message));
    return base64.encode(encryptedBytes);
  }

  @override
  String decrypt() {
    // TODO: implement decrypt
    throw UnimplementedError();
  }
}
