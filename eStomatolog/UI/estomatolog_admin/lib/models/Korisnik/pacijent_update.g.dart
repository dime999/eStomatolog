// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacijentUpdateModel _$PacijentUpdateModelFromJson(Map<String, dynamic> json) =>
    PacijentUpdateModel(
      json['korisnikId'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['korisnickoIme'] as String?,
      json['status'] as bool?,
      json['gradId'] as int?,
      (json['ulogeIdList'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['ordinacijeIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      json['password'] as String?,
      json['passwordPotvrda'] as String?,
    );

Map<String, dynamic> _$PacijentUpdateModelToJson(
        PacijentUpdateModel instance) =>
    <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'status': instance.status,
      'ordinacijeIdList': instance.ordinacijeIdList,
      'ulogeIdList': instance.ulogeIdList,
      'gradId': instance.gradId,
      'password': instance.password,
      'passwordPotvrda': instance.passwordPotvrda,
    };
