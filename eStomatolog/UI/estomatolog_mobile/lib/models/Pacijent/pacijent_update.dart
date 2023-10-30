import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pacijent_update.g.dart';

@JsonSerializable()
class PacijentUpdateModel {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  bool? status;
  List<int>? ordinacijeIdList;
  List<int>? ulogeIdList;
  int? gradId;

  PacijentUpdateModel(
      this.korisnikId,
      this.ime,
      this.prezime,
      this.email,
      this.telefon,
      this.korisnickoIme,
      this.status,
      this.gradId,
      this.ulogeIdList,
      this.ordinacijeIdList);

  factory PacijentUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$PacijentUpdateModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PacijentUpdateModelToJson(this);
}
