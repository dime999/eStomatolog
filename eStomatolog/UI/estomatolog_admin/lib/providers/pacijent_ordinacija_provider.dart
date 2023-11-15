import 'dart:convert';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija_info.dart';
import 'package:http/http.dart' as http;
import 'package:estomatolog_admin/models/Pacijent/pacijent_ordinacija.dart';
import 'package:estomatolog_admin/models/search_result.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';

class PacijentOrdinacijaProvider extends BaseProvider<PacijentOrdinacija> {
  late String _baseUrl;
  PacijentOrdinacijaProvider() : super("GetPacijentiByOrdinacijaId") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "https://localhost:7265/",
    );
  }

  @override
  PacijentOrdinacija fromJson(data) {
    return PacijentOrdinacija.fromJson(data);
  }

  Future<SearchResult<OrdinacijaInfo>> getByPacijentId(int id) async {
    String endpointPacijentOrdinacija = "GetOrdinacijeByPacijentId";
    var url = "$_baseUrl$endpointPacijentOrdinacija/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<OrdinacijaInfo>();

      for (var item in data) {
        result.result.add(OrdinacijaInfo.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
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
}
