import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:tuple/tuple.dart';
import 'package:encrypt/encrypt.dart';

import 'package:hackaton_bbva_abi/crypto/algorithms/cipher.dart';
import 'package:hackaton_bbva_abi/crypto/commons/commons.dart';

class Aes implements Cipher {
  String key;
  String iv;
  String ek;
  String message;
  String padding_type; // PCKS7
  String encrypted_message; // as base64
  String random_padding;

  void set_key(String key) {
    this.key = key;
  }

  String get get_key {
    return key;
  }

  void set_iv(String iv) {
    this.iv = iv;
  }

  String get get_iv {
    return iv;
  }

  void set_message(String message) {
    this.message = message;
  }

  String get get_message {
    return message;
  }

  void set_padding_type(String padding_type) {
    this.padding_type = padding_type;
  }

  String get get_padding_type {
    return padding_type;
  }

  void set_encrypted_message(String encrypted_message) {
    this.encrypted_message = encrypted_message;
  }

  String get get_encrypted_message {
    return encrypted_message;
  }

  void set_random_padding(String random_padding) {
    this.random_padding = random_padding;
  }

  String get get_random_padding {
    return random_padding;
  }

  @override
  String encrypt() {
    try {
      final padding = ArrayCommons.genRandomWithNonZero(8);
      var keyndIV = this.getKeyAndIvPadded(this.get_key, padding);
      final key = Key(keyndIV.item1);
      final iv = IV(keyndIV.item2);
      this.set_iv(iv.base16);
      this.ek = key.base16;

      final encrypter = Encrypter(
          AES(key, mode: AESMode.cbc, padding: this.get_padding_type));
      final encrypted = encrypter.encrypt(this.get_message, iv: iv);

      Uint8List encryptedBytesWithPadding = Uint8List.fromList(
          ArrayCommons.createUint8ListFromString(this.get_random_padding) +
              padding +
              encrypted.bytes);
      final encryptedMessage = base64.encode(encryptedBytesWithPadding);
      this.set_encrypted_message(encryptedMessage);
      return encryptedMessage;
    } catch (error) {
      throw error;
    }
  }

  @override
  String decrypt() {
    try {
      Uint8List encryptedBytesWithPadding =
          base64.decode(this.get_encrypted_message);

      Uint8List encryptedBytes = encryptedBytesWithPadding.sublist(
          16, encryptedBytesWithPadding.length);
      final padding = encryptedBytesWithPadding.sublist(8, 16);
      var keyndIV = this.getKeyAndIvPadded(this.key, padding);
      final key = Key(keyndIV.item1);
      final iv = IV(keyndIV.item2);

      final encrypter = Encrypter(
          AES(key, mode: AESMode.cbc, padding: this.get_padding_type));
      final decrypted =
          encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
      return decrypted;
    } catch (error) {
      throw error;
    }
  }

  Tuple2<Uint8List, Uint8List> getKeyAndIvPadded(
      String passphrase, Uint8List salt) {
    var password = ArrayCommons.createUint8ListFromString(passphrase);
    Uint8List concatenatedHashes = Uint8List(0);
    Uint8List currentHash = Uint8List(0);
    bool enoughBytesForKey = false;
    Uint8List preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      if (currentHash.length > 0)
        preHash = Uint8List.fromList(currentHash + password + salt);
      else
        preHash = Uint8List.fromList(password + salt);

      currentHash = md5.convert(preHash).bytes;
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
    }

    var keyBtyes = concatenatedHashes.sublist(0, 32);
    var ivBtyes = concatenatedHashes.sublist(32, 48);
    return new Tuple2(keyBtyes, ivBtyes);
  }
}
