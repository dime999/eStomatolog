import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  String ime;
  String prezime;
  String? email;
  String? password;
  String? passwordPotvrda;
  String? telefon;
  String? korisnickoIme;
  bool? status;
  List<int>? specijalizacijeId;
  List<int>? ordinacijeIdList;
  List<int>? ulogeIdList;
  int? gradId;

  Korisnik(
      this.ime,
      this.prezime,
      this.email,
      this.telefon,
      this.korisnickoIme,
      this.status,
      this.gradId,
      this.specijalizacijeId,
      this.ulogeIdList,
      this.ordinacijeIdList,
      this.password,
      this.passwordPotvrda);

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
