import 'dart:convert';
import 'package:estomatolog_mobile/models/Slika/slika_insert.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SlikaProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _getSlikeEndpoint = "OrdinacijaSlikeIds?ordinacijaId=";
  final String _slikaDelete = "Slika?id=";
  SlikaProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7265/");
  }

  Future<int> insertSlikaOrdinacija(SlikaInsert requestModel) async {
    var uri = Uri.parse("https://localhost:7265/InsertOrdinacijaSlika");

    var request = http.MultipartRequest('POST', uri)
      ..fields['OrdinacijaId'] = requestModel.OrdinacijaId.toString()
      ..files.add(await http.MultipartFile.fromPath(
          'SlikaFile', requestModel.SlikaFile));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      SlikaInsert value = SlikaInsert.fromJson(data);
      return value.OrdinacijaId;
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<List<int>> getSlikeIds(int ordinacijaId) async {
    var url = "$_baseUrl$_getSlikeEndpoint$ordinacijaId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<int> slikeIds = List<int>.from(responseData["slikeIds"]);
      return slikeIds;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<void> delete(int id) async {
    var url = "$_baseUrl$_slikaDelete$id";
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
