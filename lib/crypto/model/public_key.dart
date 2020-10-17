import 'package:flutter/material.dart';
import 'package:pointycastle/pointycastle.dart';

class AsymetricPublicKey {
  String modulus;
  String exponent;

  AsymetricPublicKey({
    @required this.modulus,
    @required this.exponent
  });

  void set set_exponent(String exponent) {
    this.exponent = exponent;
  }

  void set set_modulus(String modulus) {
    this.modulus = modulus;
  }

  String get get_modulus {
    return modulus;
  }

  String get get_exponent {
    return exponent;
  }

  RSAPublicKey to_rsa_public_key() {
    return RSAPublicKey(BigInt.parse(this.get_modulus), BigInt.parse(this.get_exponent));
  }

  factory AsymetricPublicKey.fromJson(Map<String, dynamic> json) {
    return AsymetricPublicKey(
      modulus: json['modulus'] as String,
      exponent: json['exponent'] as String
    );
  }
}