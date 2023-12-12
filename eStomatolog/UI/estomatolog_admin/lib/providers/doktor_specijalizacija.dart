import 'dart:convert';
import 'package:estomatolog_admin/models/Specijalizacija/doktorSpecijalizacija.dart';
import 'package:estomatolog_admin/models/search_result.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class DoktorSpecijalizacijaProvider
    extends BaseProvider<DoktorSpecijalizacija> {
  late String _baseUrl;
  DoktorSpecijalizacijaProvider() : super("DoktorSpecijalizacija") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "https://localhost:7265/",
    );
  }

  @override
  DoktorSpecijalizacija fromJson(data) {
    return DoktorSpecijalizacija.fromJson(data);
  }

  Future<SearchResult<DoktorSpecijalizacija>> getByDoktorId(int id) async {
    String endpoint = "GetSpecijalizacijeByDoktorId";
    var url = "$_baseUrl$endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<DoktorSpecijalizacija>();
      for (var item in data) {
        result.result.add(DoktorSpecijalizacija.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
