import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik_kartica.g.dart';

@JsonSerializable()
class KorisnikKartica {
  int id;
  int? korisnikId;
  String brojKartice;
  String vrstaKartica;
  String datumIsteka;
  String? cvv;

  KorisnikKartica(this.id, this.korisnikId, this.brojKartice, this.vrstaKartica,
      this.datumIsteka, this.cvv);

  factory KorisnikKartica.fromJson(Map<String, dynamic> json) =>
      _$KorisnikKarticaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KorisnikKarticaToJson(this);
}
