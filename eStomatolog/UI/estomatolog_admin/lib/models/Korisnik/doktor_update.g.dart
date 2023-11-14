// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doktor_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoktorUpdateModel _$DoktorUpdateModelFromJson(Map<String, dynamic> json) =>
    DoktorUpdateModel(
      json['ime'] as String?,
      json['prezime'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['korisnickoIme'] as String?,
      json['status'] as bool?,
      json['gradId'] as int?,
      (json['specijalizacijeIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      (json['ulogeIdList'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['ordinacijeIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$DoktorUpdateModelToJson(DoktorUpdateModel instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'status': instance.status,
      'specijalizacijeIdList': instance.specijalizacijeIdList,
      'ordinacijeIdList': instance.ordinacijeIdList,
      'ulogeIdList': instance.ulogeIdList,
      'gradId': instance.gradId,
    };
