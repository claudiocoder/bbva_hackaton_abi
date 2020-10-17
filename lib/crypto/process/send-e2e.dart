import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hackaton_bbva_abi/crypto/algorithms/aes.dart';
import 'package:hackaton_bbva_abi/crypto/algorithms/rsa.dart';
import 'package:hackaton_bbva_abi/crypto/commons/commons.dart';
import 'package:hackaton_bbva_abi/crypto/model/encrypted_message.dart';
import 'package:hackaton_bbva_abi/crypto/model/public_key.dart';

class SendE2eData {
  String pawPrint; // as string
  String bioFace; // as string
  AsymetricPublicKey publicKey;

  SendE2eData(String bioFace, String pawPrint, AsymetricPublicKey publicKey) {
    this.bioFace = bioFace;
    this.pawPrint = pawPrint;
    this.publicKey = publicKey;
  }

  EncryptedMessage doProcess() {
    try {
      // generates random EK
      final String EK = ArrayCommons.getRandString(32);
      final String RP = ArrayCommons.getRandString(8); //random padding

      Aes aes = new Aes();
      aes.set_padding_type("PKCS7");
      aes.set_random_padding(RP);
      aes.set_message(bioFace);
      aes.set_key(EK);
      final finalMessage = aes.encrypt();

      Rsa rsa = new Rsa(this.publicKey);
      rsa.set_message(finalMessage);
      final encryptedBio = rsa.encrypt();

      final key = utf8.encode(pawPrint);
      final bytes = utf8.encode(encryptedBio);

      final hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
      final digest = hmacSha256.convert(bytes);

      final hashedMessage = base64.encode(digest.bytes);

      return new EncryptedMessage('$encryptedBio.$hashedMessage');
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
