import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pacijent_ordinacija.g.dart';

@JsonSerializable()
class PacijentOrdinacija {
  String? pacijentIme;
  String? pacijentPrezime;
  late int korisnikId;
  late int pacijentId;

  PacijentOrdinacija(
      this.pacijentIme, this.pacijentPrezime, this.korisnikId, this.pacijentId);

  factory PacijentOrdinacija.fromJson(Map<String, dynamic> json) =>
      _$PacijentOrdinacijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PacijentOrdinacijaToJson(this);
}
