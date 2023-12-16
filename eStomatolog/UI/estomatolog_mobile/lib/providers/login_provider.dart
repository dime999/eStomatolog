import 'dart:convert';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _login_endpoint = "Login";
  LoginProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:7265/");
  }
  Future<dynamic> login() async {
    var url =
        "$_baseUrl$_login_endpoint?Username=${Authorization.korisnickoIme}&Password=${Authorization.lozinka}";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    try {
      var response = await http.get(uri, headers: headers);
      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        var prviUlogaId = data['korisniciUloges'][0]['ulogaId'];
        var korisnikId = data['korisnikId'];
        Authorization.korisnikId = korisnikId;
        if (prviUlogaId == 1) {
          throw Exception("Aplikaciji mođe pristupiti samo pacijent");
        } else {
          return data;
        }
      } else {
        throw Exception("Nepoznata greška!");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception(
          "Failed to connect to the server. Please check your internet connection.");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Nije autorizovano");
    } else {
      throw Exception("Desila se greška");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.korisnickoIme ?? "";
    String password = Authorization.lozinka ?? "";
    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }
}
