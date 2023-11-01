import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doktor_ordinacija.g.dart';

@JsonSerializable()
class DoktorOrdinacija {
  String? doktorIme;
  String? doktorPrezime;
  late int korisnikId;
  late int doktorId;

  DoktorOrdinacija(
      this.doktorIme, this.doktorPrezime, this.korisnikId, this.doktorId);

  factory DoktorOrdinacija.fromJson(Map<String, dynamic> json) =>
      _$DoktorOrdinacijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DoktorOrdinacijaToJson(this);
}
