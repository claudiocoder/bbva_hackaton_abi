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
            "e59eb116f1ddb6c5f37cb15a185fdd9d1ae7f8eb3b8bf2c293e25e92535a9e7c20bac3acbf33de83af5e1c0e76e7cafb8087f54781903c8f106a7f9c14441934e0b09de12fe0609039da578af8eabaa9771bfc33c7adf7a85c0f4aff3b1563f6ddf61fa7cc674c4e408b0d5e2f95ec4436e859b6ca2d38d0a82184751b5fce6eb78aeb35903303e67abb8e7817181bfe8b6b7413a7e956e00a0fb491a9ec02279422d01157e0740e461e5691c78ff84f08cce406d7f9068dd9ab6bb5f23a8b58a8d5ae0f10eabffd85a8d88efa595e72d4cb0d65e00405a7a057d8c950742c920fc6bfd14b6901edaf49c4c7e4a5214da34faeb03002b293b314fb421a3f2387",
        exponent: '10001');
    final String data = "UklGRiQOAQBXQVZFZm10IBAAAAABAAAAAAAAAAAAAAAAAAAAAAAhello";
    final String key = "Esto es la llave de prueba987654";
    final process = new SendE2eData(
      data,
      key,
      pb
    );
    final message = process.doProcess();
    expect(message != null, true);
    expect(message.get_encryptedCredential.length > 0, true);
  });
}
