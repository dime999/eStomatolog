import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user_update.g.dart';

@JsonSerializable()
class UserUpdateModel {
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  bool? status;
  List<int>? ulogeIdList;
  List<int>? ordinacijeIdList;
  int? gradId;
  String? password;
  String? passwordPotvrda;

  UserUpdateModel(
      this.ime,
      this.prezime,
      this.email,
      this.telefon,
      this.korisnickoIme,
      this.status,
      this.gradId,
      this.ordinacijeIdList,
      this.ulogeIdList,
      this.password,
      this.passwordPotvrda);

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserUpdateModelToJson(this);
}
