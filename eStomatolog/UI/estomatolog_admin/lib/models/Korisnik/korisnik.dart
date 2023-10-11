import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  String? password;
  String? passwordPotvrda;
  bool? status;

  Korisnik(this.korisnikId, this.ime, this.prezime, this.email, this.telefon,
      this.korisnickoIme, this.password, this.passwordPotvrda, this.status);

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
