import 'dart:convert';

import 'package:estomatolog_admin/models/Izvjestaj/izvjestaj.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class OrdinacijaProvider extends BaseProvider<Ordinacija> {
  late String _baseUrl;
  final String _izvjestaj = "getIzvjestaj/";
  OrdinacijaProvider() : super("Ordinacija") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "https://localhost:7265/",
    );
  }

  @override
  Ordinacija fromJson(data) {
    return Ordinacija.fromJson(data);
  }

  Future<dynamic> getIzvjestaj(id) async {
    var url = "$_baseUrl$_izvjestaj$id";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Izvjestaj izvjestaj;
      izvjestaj = Izvjestaj.fromJson(data);
      return izvjestaj;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
