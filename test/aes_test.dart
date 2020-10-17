// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:hackaton_bbva_abi/crypto/algorithms/aes.dart';
import 'package:hackaton_bbva_abi/crypto/commons/commons.dart';

void main() {
  test('AES encryption', () {
    final String bioFace = "Mensaje de prueba";
    // generates random EK
    final String EK = ArrayCommons.getRandString(32);
    final String RP = ArrayCommons.getRandString(8); //random padding

    Aes aes = Aes();
    aes.set_padding_type("PKCS7");
    aes.set_random_padding(RP);
    aes.set_message(bioFace);
    aes.set_key(EK);
    final finalMessage = aes.encrypt();
    print('Final message: $finalMessage');
  });
}
