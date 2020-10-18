import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:hackaton_bbva_abi/crypto/algorithms/cipher.dart';
import 'package:hackaton_bbva_abi/crypto/model/public_key.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:tuple/tuple.dart';

class Rsa implements Cipher {
  String message;
  String encryptedMessage;
  AsymetricPublicKey publicKey;
  RSAPrivateKey privateKey;

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
    this.encryptedMessage = base64.encode(encryptedBytes);
    return this.encryptedMessage;
  }

  @override
  String decrypt() {
    final cipher = PKCS1Encoding(RSAEngine());
    cipher.init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    Uint8List output = cipher.process(base64Decode(encryptedMessage));
    return utf8.decode(output);
  }

  Tuple2<RSAPublicKey, RSAPrivateKey> generateKeyPair() {
    var random = Random.secure();
    var key = Uint8List.fromList(List.generate(32, (_) => random.nextInt(255)));
    var secureRandom = FortunaRandom()..seed(KeyParameter(key));
    var rsaParams = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 12);
    var keyGenerator = RSAKeyGenerator()
      ..init(ParametersWithRandom(rsaParams, secureRandom));
    AsymmetricKeyPair keys = keyGenerator.generateKeyPair();
    return Tuple2(keys.publicKey, keys.privateKey);
  }
}
