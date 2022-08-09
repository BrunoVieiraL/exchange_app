import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinAPI {
  var request =
      Uri.parse("https://api.hgbrasil.com/finance?format=json&key=4de16a13");

  Future<Map> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }
}
