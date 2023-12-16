import 'dart:convert';
import 'package:estomatolog_mobile/models/Doktor/doktor.dart';
import 'package:estomatolog_mobile/models/Doktor/doktor_recommended.dart';
import 'package:estomatolog_mobile/models/search_result.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class DoktorProvider extends BaseProvider<Doktor> {
  late String _baseUrl;
  DoktorProvider() : super("Doktor") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "http://10.0.2.2:7265/",
    );
  }

  @override
  Doktor fromJson(data) {
    return Doktor.fromJson(data);
  }

  Future<SearchResult<DoktorRecommended>> getRecommended(id) async {
    String getRecommended = "GetRecommended";
    var url = "$_baseUrl$getRecommended/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<DoktorRecommended>();

      for (var item in data) {
        result.result.add(DoktorRecommended.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<dynamic> getByKorisnikId(id) async {
    String getByKorisnik = "GetByKorisnikId";
    var url = "$_baseUrl$getByKorisnik/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Doktor doktor;
      doktor = Doktor.fromJson(data);
      return doktor;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
