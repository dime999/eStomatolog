import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pacijent_insert.g.dart';

@JsonSerializable()
class PacijentInsertModel {
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  bool? status;
  List<int>? ordinacijeIdList;
  List<int>? ulogeIdList;
  int? gradId;
  String? password;
  String? passwordPotvrda;
  DateTime? datumRodjenja;

  PacijentInsertModel(
      this.ime,
      this.prezime,
      this.email,
      this.telefon,
      this.korisnickoIme,
      this.status,
      this.gradId,
      this.ulogeIdList,
      this.ordinacijeIdList,
      this.password,
      this.passwordPotvrda,
      this.datumRodjenja);

  factory PacijentInsertModel.fromJson(Map<String, dynamic> json) =>
      _$PacijentInsertModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PacijentInsertModelToJson(this);
}
