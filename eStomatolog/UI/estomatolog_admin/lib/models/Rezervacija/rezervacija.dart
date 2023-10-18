import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'rezervacija.g.dart';

@JsonSerializable()
class Rezervacija {
  int rezervacijaId;
  DateTime datum;
  String? email;
  String? doktorIme;
  String doktorPrezime;
  String pacijentPrezime;
  String? pacijentIme;
  String? ordinacijaIme;
  DateTime terminVrijeme;

  Rezervacija(
      this.rezervacijaId,
      this.datum,
      this.doktorIme,
      this.doktorPrezime,
      this.pacijentIme,
      this.pacijentPrezime,
      this.ordinacijaIme,
      this.email,
      this.terminVrijeme);

  factory Rezervacija.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}
