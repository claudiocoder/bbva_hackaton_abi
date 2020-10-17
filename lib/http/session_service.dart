import 'dart:convert';
import 'package:hackaton_bbva_abi/crypto/model/auth.dart';
import 'package:http/http.dart';
import 'package:hackaton_bbva_abi/crypto/model/public_key.dart';
import 'package:hackaton_bbva_abi/constants/app_http_urls.dart';

class SessionService {
  Future<AsymetricPublicKey> getPublicKey() async {
    Response response = await get(HttpUrls.e2eKey);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      AsymetricPublicKey publickey = body
          .map(
            (dynamic item) => AsymetricPublicKey.fromJson(item),
          )
          .single;

      return publickey;
    } else {
      throw "Can't get public key.";
    }
  }

  Future<bool> login(Auth request) async {
    Response res = await post(HttpUrls.login,
          headers: {
            "Content-Type": "application/json"
          },
          body: request.get_as_json
      );
    if (res.statusCode == 200) {
      return true;
    } else {
      throw "Can't login.";
    }
  }
}
