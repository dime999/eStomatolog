import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ordinacija_pacijent.g.dart';

@JsonSerializable()
class OrdinacijaPacijent {
  int ordinacijaId;
  String ordinacijaNaziv;
  String ordinacijaAdresa;

  OrdinacijaPacijent(
      this.ordinacijaId, this.ordinacijaNaziv, this.ordinacijaAdresa);

  factory OrdinacijaPacijent.fromJson(Map<String, dynamic> json) =>
      _$OrdinacijaPacijentFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OrdinacijaPacijentToJson(this);
}
