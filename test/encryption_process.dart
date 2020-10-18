// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:hackaton_bbva_abi/crypto/model/public_key.dart';
import 'package:hackaton_bbva_abi/crypto/process/send-e2e.dart';

void main() {
  test('Process encryption', () {
    final AsymetricPublicKey pb = new AsymetricPublicKey(
        modulus:
            "879440EE99A63459E467829098FC446440E124C12D0F7A2538833EDA55469356156151F33F3D3D28CA0C287CFB76D5541AAF8CA3281BE9EA128EB3BE8ED3B0ED29EAA0E8DB5011BAECA58D573F71E9D16259443CD075DDA2D58F20C84CCC523AB5E74411D1BEDEEF385028286087B797F7251DC3AB90F4EC96DF9A6E5916230E60245DB449850A84CB655056E3AEFB6691EF5EC6543625FA5FFF05A964281082E8DEFAFB30DD7FE0921B4BEB11C0491A0479CC085A467531DC9DA50F8D40AEC4F7739C0597BE73969C691B0234DF97830C6F5EAF7352604B32CB21CFA4391F22246A51CBD358DFA9268ED90DC4C735DD9414F5FBC1C54D9AD492EFE44E22343D",
        exponent: '10001');
    final String data = "Esto es un mensaje de prueba";
    final String key = "Esto es la llave de prueba";
    final process = new SendE2eData(
      data,
      key,
      pb
    );
    final message = process.doProcess();
    expect(message != null, true);
    expect(message.get_encryptedCredential.length > 0, true);
    print('The final message is: ${message.encryptedCredential}');
  });
}
