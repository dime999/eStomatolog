import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doktor.g.dart';

@JsonSerializable()
class Doktor {
  int? id;
  String? ime;
  String? prezime;
  int korisnikId;

  Doktor(this.id, this.ime, this.prezime, this.korisnikId);

  factory Doktor.fromJson(Map<String, dynamic> json) => _$DoktorFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DoktorToJson(this);
}
