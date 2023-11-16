// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doktor_recommended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoktorRecommended _$DoktorRecommendedFromJson(Map<String, dynamic> json) =>
    DoktorRecommended(
      json['id'] as int,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['korisnikId'] as int,
      (json['doktorOrdinacije'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DoktorRecommendedToJson(DoktorRecommended instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnikId': instance.korisnikId,
      'doktorOrdinacije': instance.doktorOrdinacije,
    };
