import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik_update.g.dart';

@JsonSerializable()
class KorisnikUpdateModel {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  bool? status;
  List<int>? specijalizacijeId;
  List<int>? ordinacijeId;
  List<int>? ulogeIdList;
  int? gradId;

  KorisnikUpdateModel(
      this.korisnikId,
      this.ime,
      this.prezime,
      this.email,
      this.telefon,
      this.korisnickoIme,
      this.status,
      this.gradId,
      this.specijalizacijeId,
      this.ulogeIdList,
      this.ordinacijeId);

  factory KorisnikUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$KorisnikUpdateModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikUpdateModelToJson(this);
}
