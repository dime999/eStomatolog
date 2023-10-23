import 'dart:convert';
import 'package:estomatolog_admin/models/Nalaz/nalaz.dart';
import 'package:estomatolog_admin/models/Nalaz/nalaz_insert.dart';
import 'package:estomatolog_admin/models/search_result.dart';
import 'package:estomatolog_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class NalazProvider extends BaseProvider<NalazInsert> {
  late String _baseUrl;
  NalazProvider() : super("Dijagnoza") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "https://localhost:7265/",
    );
  }

  @override
  NalazInsert fromJson(data) {
    return NalazInsert.fromJson(data);
  }

  Future<SearchResult<Nalaz>> getByPacijentId(int id) async {
    String _endpoint = "GetByPacijent";
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Nalaz>();
      for (var item in data) {
        result.result.add(Nalaz.fromJson(item));
      }

      return result;
    } else {
      throw new Exception("Nepoznata greška!");
    }
  }
}
