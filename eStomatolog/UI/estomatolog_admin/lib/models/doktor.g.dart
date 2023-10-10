// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doktor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doktor _$DoktorFromJson(Map<String, dynamic> json) => Doktor(
      json['id'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['korisnikId'] as int,
    );

Map<String, dynamic> _$DoktorToJson(Doktor instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnikId': instance.korisnikId,
    };
