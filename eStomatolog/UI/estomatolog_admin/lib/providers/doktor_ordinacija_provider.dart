import 'dart:convert';
import 'package:estomatolog_admin/models/Doktor/doktor_ordinacija.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija_info.dart';
import 'package:estomatolog_admin/models/search_result.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class DoktorOrdinacijaProvider extends BaseProvider<DoktorOrdinacija> {
  late String _baseUrl;

  DoktorOrdinacijaProvider() : super("GetByOrdinacijaId") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "http://localhost:7265/",
    );
  }

  @override
  DoktorOrdinacija fromJson(data) {
    return DoktorOrdinacija.fromJson(data);
  }

  Future<SearchResult<OrdinacijaInfo>> getByDoktorIdInfo(int id) async {
    String endpoint = "GetByOrdinacijaInfo";
    var url = "$_baseUrl$endpoint/$id";
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

  Future<SearchResult<DoktorOrdinacija>> getByOrdinacijaId(int id) async {
    String endpoint = "GetByOrdinacijaId";
    var url = "$_baseUrl$endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<DoktorOrdinacija>();

      for (var item in data) {
        result.result.add(DoktorOrdinacija.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
