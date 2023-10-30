import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik_basic.g.dart';

@JsonSerializable()
class KorisnikBasic {
  int korisnikId;
  String? ime;
  String? prezime;
  String? email;

  KorisnikBasic(
    this.korisnikId,
    this.ime,
    this.prezime,
    this.email,
  );

  factory KorisnikBasic.fromJson(Map<String, dynamic> json) =>
      _$KorisnikBasicFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikBasicToJson(this);
}
