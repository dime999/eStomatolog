import 'dart:convert';
import 'package:estomatolog_mobile/models/Rezervacija/rezervacija.dart';
import 'package:estomatolog_mobile/models/search_result.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RezervacijaProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "GetRezervacijeByOrdinacija/";
  final String _endpointDelete = "Rezervacija?id=";
  final String _endpointPacijent = "GetRezervacijeByPacijent";
  RezervacijaProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7265/");
  }

  Future<SearchResult<Rezervacija>> get(int id) async {
    var url = "$_baseUrl$_endpoint$id";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Rezervacija>();

      for (var item in data) {
        result.result.add(Rezervacija.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<SearchResult<Rezervacija>> getByPacijent(
      int ordinacijaId, int pacijentId) async {
    var url = "$_baseUrl$_endpointPacijent/$ordinacijaId/$pacijentId";
    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Rezervacija>();

      for (var item in data) {
        result.result.add(Rezervacija.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<void> delete(int id) async {
    var url = "$_baseUrl$_endpointDelete$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception("Brisanje nije uspelo");
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
