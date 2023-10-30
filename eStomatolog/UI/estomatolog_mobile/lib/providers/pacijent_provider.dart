import 'dart:convert';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class PacijentProvider extends BaseProvider<Pacijent> {
  late String _baseUrl;
  PacijentProvider() : super("Pacijent") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "https://10.0.2.2:7265/",
    );
  }

  @override
  Pacijent fromJson(data) {
    return Pacijent.fromJson(data);
  }

  Future<dynamic> getByKorisnikId(id) async {
    String getByKorisnik = "GetPacijentByKorisnikId";
    var url = "$_baseUrl$getByKorisnik/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Pacijent pacijent;
      pacijent = Pacijent.fromJson(data);
      return pacijent;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
