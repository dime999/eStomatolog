import 'dart:convert';
import 'package:estomatolog_mobile/models/Korisnik/user_update.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik_basic.dart';
import 'package:estomatolog_mobile/models/Korisnik/pacijent_insert.dart';
import 'package:estomatolog_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KorisniciProvider extends BaseProvider<Korisnik> {
  late String _baseUrl;
  late final String _endpoint = "Korisnik";
  KorisniciProvider() : super("Korisnik") {
    _baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "https://10.0.2.2:7265/",
    );
  }

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

  Future<dynamic> getByKorisickoIme(ime) async {
    String altRoute = "GetByKorisnickoIme?ime=";
    var url = "$_baseUrl$altRoute$ime";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      KorisnikBasic korisnik;
      korisnik = KorisnikBasic.fromJson(data);
      return korisnik;
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<PacijentInsertModel> insertPacijent(
      [PacijentInsertModel? request]) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return PacijentInsertModel.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<UserUpdateModel> updateUser(int id, [UserUpdateModel? request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    print(uri);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return UserUpdateModel.fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }
}
