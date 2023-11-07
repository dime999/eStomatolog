import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik_kartica_insert.g.dart';

@JsonSerializable()
class KorisnikKarticaInsert {
  int? korisnikId;
  String? brojKartice;
  String? vrstaKartica;
  String? datumIsteka;
  String? cvv;

  KorisnikKarticaInsert(this.korisnikId, this.brojKartice, this.vrstaKartica,
      this.datumIsteka, this.cvv);

  factory KorisnikKarticaInsert.fromJson(Map<String, dynamic> json) =>
      _$KorisnikKarticaInsertFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikKarticaInsertToJson(this);
}
