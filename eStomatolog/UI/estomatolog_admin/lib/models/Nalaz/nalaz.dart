import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'nalaz.g.dart';

@JsonSerializable()
class Nalaz {
  String? doktorIme;
  String? opis;
  DateTime? datum;

  Nalaz(this.doktorIme, this.opis, this.datum);

  factory Nalaz.fromJson(Map<String, dynamic> json) => _$NalazFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NalazToJson(this);
}
