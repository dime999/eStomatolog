// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pacijent _$PacijentFromJson(Map<String, dynamic> json) => Pacijent(
      json['id'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['korisnikId'] as int,
    );

Map<String, dynamic> _$PacijentToJson(Pacijent instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnikId': instance.korisnikId,
    };
