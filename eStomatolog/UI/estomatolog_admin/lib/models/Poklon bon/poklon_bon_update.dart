import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'poklon_bon_update.g.dart';

@JsonSerializable()
class PoklonBonUpdate {
  int pacijentId;
  int ordinacijaId;
  String? kod;
  double iznosPlacanja;
  String imePrezimeKorisnikaKojiKoristi;
  bool placeno;
  DateTime datumIstekaKartice;
  String brojKartice;
  String? cvcCvvKod;

  bool iskoristeno;

  PoklonBonUpdate(
      this.pacijentId,
      this.ordinacijaId,
      this.kod,
      this.iznosPlacanja,
      this.imePrezimeKorisnikaKojiKoristi,
      this.placeno,
      this.datumIstekaKartice,
      this.brojKartice,
      this.cvcCvvKod,
      this.iskoristeno);

  factory PoklonBonUpdate.fromJson(Map<String, dynamic> json) =>
      _$PoklonBonUpdateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PoklonBonUpdateToJson(this);
}
