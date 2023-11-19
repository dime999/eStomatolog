import 'dart:convert';
import 'package:estomatolog_mobile/models/KorisnikKartica/korisnik_kartica.dart';
import 'package:estomatolog_mobile/models/KorisnikKartica/korisnik_kartica_insert.dart';
import 'package:estomatolog_mobile/models/search_result.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KorisnikKarticaProvider extends BaseProvider<KorisnikKartica> {
  final String _default = "KorisnikKartica";
  late String _baseUrl;
  KorisnikKarticaProvider() : super("KorisnikKartica") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "http://10.0.2.2:7265/",
    );
  }

  @override
  KorisnikKartica fromJson(data) {
    return KorisnikKartica.fromJson(data);
  }

  Future<KorisnikKarticaInsert> novaKartica(
      [KorisnikKarticaInsert? request]) async {
    var url = "$_baseUrl$_default";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return KorisnikKarticaInsert.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<SearchResult<KorisnikKartica>> getByKorisnikId(int id) async {
    String endpoint = "GetKartice";
    var url = "$_baseUrl$endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<KorisnikKartica>();

      for (var item in data) {
        result.result.add(KorisnikKartica.fromJson(item));
      }

      return result;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
