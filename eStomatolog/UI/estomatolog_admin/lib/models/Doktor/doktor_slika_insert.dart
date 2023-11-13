import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doktor_slika_insert.g.dart';

@JsonSerializable()
class DoktorSlikaInsert {
  int DoktorId;
  String SlikaFile;

  DoktorSlikaInsert(this.DoktorId, this.SlikaFile);

  factory DoktorSlikaInsert.fromJson(Map<String, dynamic> json) =>
      _$DoktorSlikaInsertFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DoktorSlikaInsertToJson(this);
}
