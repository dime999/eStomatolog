import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'poklon_bon_insert.g.dart';

@JsonSerializable()
class PoklonBonInsert {
  String? kod;
  int? iznosPlacanja;
  int pacijentId;
  int ordinacijaId;
  String? imePrezimeKorisnikaKojiKoristi;
  bool placeno;
  String? brojKartice;
  DateTime? datumIstekaKartice;
  String? cvcCvvKod;
  bool iskoristeno;

  PoklonBonInsert(
      this.kod,
      this.iznosPlacanja,
      this.pacijentId,
      this.ordinacijaId,
      this.imePrezimeKorisnikaKojiKoristi,
      this.placeno,
      this.brojKartice,
      this.datumIstekaKartice,
      this.cvcCvvKod,
      this.iskoristeno);

  factory PoklonBonInsert.fromJson(Map<String, dynamic> json) =>
      _$PoklonBonInsertFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PoklonBonInsertToJson(this);
}
