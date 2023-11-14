import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doktor_update.g.dart';

@JsonSerializable()
class DoktorUpdateModel {
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  bool? status;
  List<int>? specijalizacijeIdList;
  List<int>? ordinacijeIdList;
  List<int>? ulogeIdList;
  int? gradId;

  DoktorUpdateModel(
      this.ime,
      this.prezime,
      this.email,
      this.telefon,
      this.korisnickoIme,
      this.status,
      this.gradId,
      this.specijalizacijeIdList,
      this.ulogeIdList,
      this.ordinacijeIdList);

  factory DoktorUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$DoktorUpdateModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DoktorUpdateModelToJson(this);
}
