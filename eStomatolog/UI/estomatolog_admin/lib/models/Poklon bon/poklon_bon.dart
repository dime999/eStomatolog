import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'poklon_bon.g.dart';

@JsonSerializable()
class PoklonBon {
  int poklonBonId;
  int pacijentId;
  int ordinacijaId;
  String? kod;
  double iznosPlacanja;
  String imePrezimeKorisnikaKojiKoristi;
  bool placeno;
  DateTime datumIstekaKartice;
  String brojKartice;
  String? cvcCvvKod;
  String ordinacijaNaziv;
  String pacijentIme;
  String pacijentPrezime;
  bool iskoristeno;

  PoklonBon(
      this.poklonBonId,
      this.pacijentId,
      this.ordinacijaId,
      this.kod,
      this.iznosPlacanja,
      this.imePrezimeKorisnikaKojiKoristi,
      this.placeno,
      this.datumIstekaKartice,
      this.brojKartice,
      this.cvcCvvKod,
      this.ordinacijaNaziv,
      this.pacijentIme,
      this.pacijentPrezime,
      this.iskoristeno);

  factory PoklonBon.fromJson(Map<String, dynamic> json) =>
      _$PoklonBonFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PoklonBonToJson(this);
}
