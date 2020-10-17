import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../crypto/process/send-e2e.dart' as e2e;
import '../http/session_service.dart' as session;
import 'dart:convert';

class SendInfo {
  String base64; // as string
  String path; // as string
  String signature; // as string

  SendInfo(String base64, String signature, String path) {
    this.base64 = base64;
    this.path = path;
    this.signature = signature;
  }

  Future sendInfo() async {
    final url = 'http://192.168.0.4:3000/$path';
    Map map = {"data": 'data'};
    final bodyString = json.encode(map);
    final s = new session.SessionService();
    final key = await s.getPublicKey();
    final send = new e2e.SendE2eData(this.base64, this.signature, key);
    final encrytp = send.doProcess();
    final resp =
        await http.post(url, body: {'data': encrytp.encryptedCredential});
    final decodeData = json.decode(resp.body);
    print('Respuesta: $decodeData');
    return decodeData;
  }
}
