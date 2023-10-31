import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doktor_specijalizacija.g.dart';

@JsonSerializable()
class DoktorSpecijalizacija {
  late int doktorId;
  String? specijalizacijaNaziv;

  DoktorSpecijalizacija(this.doktorId, this.specijalizacijaNaziv);

  factory DoktorSpecijalizacija.fromJson(Map<String, dynamic> json) =>
      _$DoktorSpecijalizacijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DoktorSpecijalizacijaToJson(this);
}
