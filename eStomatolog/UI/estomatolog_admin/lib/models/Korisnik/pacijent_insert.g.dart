// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacijentInsertModel _$PacijentInsertModelFromJson(Map<String, dynamic> json) =>
    PacijentInsertModel(
      json['ime'] as String?,
      json['prezime'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['korisnickoIme'] as String?,
      json['status'] as bool?,
      json['gradId'] as int?,
      (json['ulogeIdList'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['ordinacijeId'] as List<dynamic>?)?.map((e) => e as int).toList(),
      json['password'] as String?,
      json['passwordPotvrda'] as String?,
    );

Map<String, dynamic> _$PacijentInsertModelToJson(
        PacijentInsertModel instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'status': instance.status,
      'ordinacijeId': instance.ordinacijeId,
      'ulogeIdList': instance.ulogeIdList,
      'gradId': instance.gradId,
      'password': instance.password,
      'passwordPotvrda': instance.passwordPotvrda,
    };
