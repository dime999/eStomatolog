import 'dart:convert';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija_pacijent.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent_ordinacija.dart';
import 'package:estomatolog_mobile/models/search_result.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class PacijentOrdinacijaProvider extends BaseProvider<PacijentOrdinacija> {
  late String _baseUrl;
  PacijentOrdinacijaProvider() : super("GetPacijentiByOrdinacijaId") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "http://10.0.2.2:7265/",
    );
  }

  @override
  PacijentOrdinacija fromJson(data) {
    return PacijentOrdinacija.fromJson(data);
  }

  Future<SearchResult<PacijentOrdinacija>> getByOrdinacijaId(int id) async {
    String endpointPacijentOrdinacija = "GetPacijentiByOrdinacijaId";
    var url = "$_baseUrl$endpointPacijentOrdinacija/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<PacijentOrdinacija>();

      for (var item in data) {
        result.result.add(PacijentOrdinacija.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<SearchResult<OrdinacijaPacijent>> getByPacijentId(int id) async {
    String endpointPacijentOrdinacija = "GetOrdinacijeByPacijentId";
    var url = "$_baseUrl$endpointPacijentOrdinacija/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<OrdinacijaPacijent>();

      for (var item in data) {
        result.result.add(OrdinacijaPacijent.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
