// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doktor_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoktorUpdateModel _$DoktorUpdateModelFromJson(Map<String, dynamic> json) =>
    DoktorUpdateModel(
      json['korisnikId'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['korisnickoIme'] as String?,
      json['status'] as bool?,
      json['gradId'] as int?,
      (json['specijalizacijeId'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      (json['ulogeIdList'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['ordinacijeId'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DoktorUpdateModelToJson(DoktorUpdateModel instance) =>
    <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'status': instance.status,
      'specijalizacijeId': instance.specijalizacijeId,
      'ordinacijeId': instance.ordinacijeId,
      'ulogeIdList': instance.ulogeIdList,
      'gradId': instance.gradId,
    };
