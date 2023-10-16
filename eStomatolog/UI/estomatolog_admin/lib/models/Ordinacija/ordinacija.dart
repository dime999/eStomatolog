import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ordinacija.g.dart';

@JsonSerializable()
class Ordinacija {
  int ordinacijaId;
  String naziv;
  String adresa;
  String telefon;
  int gradId;

  Ordinacija(
      this.ordinacijaId, this.naziv, this.adresa, this.telefon, this.gradId);

  factory Ordinacija.fromJson(Map<String, dynamic> json) =>
      _$OrdinacijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OrdinacijaToJson(this);
}
