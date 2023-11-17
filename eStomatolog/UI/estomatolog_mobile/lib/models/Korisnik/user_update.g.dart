// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateModel _$UserUpdateModelFromJson(Map<String, dynamic> json) =>
    UserUpdateModel(
      json['ime'] as String?,
      json['prezime'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['korisnickoIme'] as String?,
      json['status'] as bool?,
      json['gradId'] as int?,
      (json['ordinacijeIdList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      (json['ulogeIdList'] as List<dynamic>?)?.map((e) => e as int).toList(),
      json['password'] as String?,
      json['passwordPotvrda'] as String?,
    );

Map<String, dynamic> _$UserUpdateModelToJson(UserUpdateModel instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'status': instance.status,
      'ulogeIdList': instance.ulogeIdList,
      'ordinacijeIdList': instance.ordinacijeIdList,
      'gradId': instance.gradId,
      'password': instance.password,
      'passwordPotvrda': instance.passwordPotvrda,
    };
