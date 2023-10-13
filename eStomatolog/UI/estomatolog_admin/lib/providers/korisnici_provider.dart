import 'dart:convert';
import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik_update.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class KorisniciProvider with ChangeNotifier {
  static String? _baseUrl;
  String _login_endpoint = "Login";
  String _endpoint = "Korisnik";
  KorisniciProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7265/");
  }
  Future<dynamic> login() async {
    var url =
        "$_baseUrl$_login_endpoint?Username=${Authorization.korisnickoIme}&Password=${Authorization.lozinka}";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw new Exception("Nepoznata greška!");
    }
  }

  Future<dynamic> getById(id) async {
    var url = "$_baseUrl$_endpoint/${id}";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Korisnik korisnik;
      korisnik = Korisnik.fromJson(data);
      return korisnik;
    } else {
      throw new Exception("Nepoznata greška!");
    }
  }

  Future<void> delete(int id) async {
    var url = "$_baseUrl$_endpoint?id=${id}";
    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception("Brisanje nije uspelo");
    }
  }

  Future<Korisnik> insert([Korisnik? request]) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return Korisnik.fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<KorisnikUpdateModel> update(int id,
      [KorisnikUpdateModel? request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return KorisnikUpdateModel.fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Nije autorizovano");
    } else {
      throw new Exception("Desila se greška");
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
