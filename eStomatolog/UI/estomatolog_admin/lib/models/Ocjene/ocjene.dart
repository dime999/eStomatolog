import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ocjene.g.dart';

@JsonSerializable()
class Ocjene {
  int doktorId;
  int pacijentId;
  DateTime datum;
  int ocjena;
  String opis;

  Ocjene(this.doktorId, this.pacijentId, this.datum, this.ocjena, this.opis);

  factory Ocjene.fromJson(Map<String, dynamic> json) => _$OcjeneFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OcjeneToJson(this);
}
