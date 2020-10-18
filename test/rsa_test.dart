// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:hackaton_bbva_abi/crypto/algorithms/rsa.dart';
import 'package:hackaton_bbva_abi/crypto/model/public_key.dart';

void main() {
  test('Rsa encryption', () {
    final String message = "Mensaje de prueba";

    Rsa rsa = Rsa(null);
    rsa.set_message(message);
    final keyPair = rsa.generateKeyPair();
    print('M: ${keyPair.item1.modulus.toRadixString(16)}');
    print('E: ${keyPair.item1.exponent.toRadixString(16)}');
    print('P: ${keyPair.item2.p.toRadixString(16)}');
    print('Q: ${keyPair.item2.q.toRadixString(16)}');
    print('PEX: ${keyPair.item2.privateExponent.toRadixString(16)}');
    print('ITEM2 MOD: ${keyPair.item2.modulus.toRadixString(16)}');
    rsa.set_public_key(new AsymetricPublicKey(
        modulus: keyPair.item1.modulus.toRadixString(16),
        exponent: keyPair.item1.exponent.toRadixString(16)));
    rsa.privateKey = keyPair.item2;
    final finalMessage = rsa.encrypt();
    final decyptedMessage = rsa.decrypt();
    expect(finalMessage != null, true);
    expect(finalMessage.length > 0, true);
    expect(decyptedMessage, message);
  });
}
