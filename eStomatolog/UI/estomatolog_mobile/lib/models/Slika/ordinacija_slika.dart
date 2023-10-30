import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ordinacija_slika.g.dart';

@JsonSerializable()
class OrdinacijaSlike {
  List<dynamic> slikeIds;

  OrdinacijaSlike(
    this.slikeIds,
  );

  factory OrdinacijaSlike.fromJson(Map<String, dynamic> json) =>
      _$OrdinacijaSlikeFromJson(json);
}
