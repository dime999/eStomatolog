import 'dart:convert';
import 'package:estomatolog_admin/models/Rezervacija/rezervacija.dart';
import 'package:estomatolog_admin/models/Rezervacija/rezervacija_insert.dart';
import 'package:estomatolog_admin/models/Termin/termin_zauzeti.dart';
import 'package:estomatolog_admin/models/search_result.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RezervacijaProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "GetRezervacijeByOrdinacija/";
  final String _endpointDelete = "Rezervacija?id=";
  final String _endpointPacijent = "GetRezervacijeByPacijent";
  final String _endpointZauzetiTermini =
      "Rezervacija/zauzeti-termini?ordinacijaId=";
  final String _datum = "&datum=";
  final String _default = "Rezervacija";
  final String _zauzeti = "OznaciZauzetim";
  RezervacijaProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7265/");
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

  Future<RezervacijaInsert> oznaciZauzetim([RezervacijaInsert? request]) async {
    var url = "$_baseUrl$_zauzeti";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return RezervacijaInsert.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<RezervacijaInsert> insert([RezervacijaInsert? request]) async {
    var url = "$_baseUrl$_default";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return RezervacijaInsert.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<SearchResult<TerminZauzeti>> getByDatum(
      int ordinacijaId, DateTime? datum) async {
    var url =
        "$_baseUrl$_endpointZauzetiTermini${ordinacijaId}${_datum}${datum}";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<TerminZauzeti>();

      for (var item in data) {
        result.result.add(TerminZauzeti.fromJson(item));
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
