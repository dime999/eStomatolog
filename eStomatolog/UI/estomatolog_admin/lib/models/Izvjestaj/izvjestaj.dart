import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'izvjestaj.g.dart';

@JsonSerializable()
class Izvjestaj {
  int ukopnoKorisnika;
  int brojDoktora;
  int brojPacijenta;
  int brojRezervacija;
  int brojAktinihRezervacija;
  int brojNeaktivnihRezervacija;
  int brojNalaza;
  int brojPoklonBonova;

  Izvjestaj(
    this.ukopnoKorisnika,
    this.brojDoktora,
    this.brojPacijenta,
    this.brojRezervacija,
    this.brojAktinihRezervacija,
    this.brojNeaktivnihRezervacija,
    this.brojNalaza,
    this.brojPoklonBonova,
  );

  factory Izvjestaj.fromJson(Map<String, dynamic> json) =>
      _$IzvjestajFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$IzvjestajToJson(this);
}
