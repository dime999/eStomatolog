import 'dart:convert';

import 'package:estomatolog_admin/models/Korisnik/doktor_update.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik_basic.dart';
import 'package:estomatolog_admin/models/Korisnik/pacijent_insert.dart';
import 'package:estomatolog_admin/models/Korisnik/pacijent_update.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KorisniciProvider extends BaseProvider<Korisnik> {
  late String _baseUrl;
  late final String _endpoint = "Korisnik";
  KorisniciProvider() : super("Korisnik") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "http://localhost:7265/",
    );
  }

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

  Future<dynamic> getByKorisickoIme(ime) async {
    String altRoute = "GetByKorisnickoIme?ime=";
    var url = "$_baseUrl$altRoute$ime";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      KorisnikBasic korisnik;
      korisnik = KorisnikBasic.fromJson(data);
      return korisnik;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<PacijentInsertModel> insertPacijent(
      [PacijentInsertModel? request]) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return PacijentInsertModel.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<DoktorUpdateModel> updateDoktor(int id,
      [DoktorUpdateModel? request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return DoktorUpdateModel.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<PacijentUpdateModel> updatePacijent(int id,
      [PacijentUpdateModel? request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return PacijentUpdateModel.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }
}
