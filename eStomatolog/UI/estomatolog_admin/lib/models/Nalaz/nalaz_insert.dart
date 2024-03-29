import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'nalaz_insert.g.dart';

@JsonSerializable()
class NalazInsert {
  int doktorId;
  int pacijentId;
  String? opis;
  DateTime? datum;

  NalazInsert(this.doktorId, this.pacijentId, this.opis, this.datum);

  factory NalazInsert.fromJson(Map<String, dynamic> json) =>
      _$NalazInsertFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NalazInsertToJson(this);
}
