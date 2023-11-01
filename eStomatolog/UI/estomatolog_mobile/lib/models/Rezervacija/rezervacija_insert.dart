import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'rezervacija_insert.g.dart';

@JsonSerializable()
class RezervacijaInsert {
  DateTime datum;
  String? email;
  int pacijentId;
  int ordinacijaId;
  int doktorId;
  int terminId;

  RezervacijaInsert(
    this.datum,
    this.email,
    this.pacijentId,
    this.ordinacijaId,
    this.doktorId,
    this.terminId,
  );

  factory RezervacijaInsert.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaInsertFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RezervacijaInsertToJson(this);
}
