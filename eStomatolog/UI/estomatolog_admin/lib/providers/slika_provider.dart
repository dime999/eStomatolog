import 'dart:convert';
import 'dart:typed_data';
import 'package:estomatolog_admin/models/Slika/ordinacija_slika.dart';
import 'package:estomatolog_admin/models/Slika/slika_insert.dart';
import 'package:estomatolog_admin/models/search_result.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SlikaProvider with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "InsertOrdinacijaSlika";
  String _getSlikeEndpoint = "OrdinacijaSlikeIds?ordinacijaId=";
  String _ucitajSlikuEndpoint = "SlikaStream?slikaId=";
  SlikaProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7265/");
  }

  Future<SlikaInsert> insertSlikaOrdinacija(SlikaInsert requestModel) async {
    var uri = Uri.parse("https://localhost:7265/InsertOrdinacijaSlika");

    var request = http.MultipartRequest('POST', uri)
      ..fields['OrdinacijaId'] = requestModel.OrdinacijaId.toString()
      ..files.add(await http.MultipartFile.fromPath(
          'SlikaFile', requestModel.SlikaFile));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return SlikaInsert.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<List<int>> getSlikeIds(int ordinacijaId) async {
    var url = "$_baseUrl$_getSlikeEndpoint${ordinacijaId}";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<int> slikeIds = List<int>.from(responseData["slikeIds"]);
      return slikeIds;
    } else {
      throw new Exception("Nepoznata greška!");
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
