import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'poklon_bon.g.dart';

@JsonSerializable()
class PoklonBon {
  String kod;
  double iznosPlacanja;
  String imePrezimeKorisnikaKojiKoristi;
  bool placeno;
  bool iskoristeno;

  PoklonBon(this.kod, this.iznosPlacanja, this.imePrezimeKorisnikaKojiKoristi,
      this.placeno, this.iskoristeno);

  factory PoklonBon.fromJson(Map<String, dynamic> json) =>
      _$PoklonBonFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PoklonBonToJson(this);
}
