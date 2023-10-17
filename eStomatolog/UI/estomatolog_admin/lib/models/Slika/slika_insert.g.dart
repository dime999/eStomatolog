// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slika_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlikaInsert _$SlikaInsertFromJson(Map<String, dynamic> json) => SlikaInsert(
      json['ordinacijaId'] as int,
      json['slikaFilePath'] as String,
    );

Map<String, dynamic> _$SlikaInsertToJson(SlikaInsert instance) =>
    <String, dynamic>{
      'ordinacijaId': instance.OrdinacijaId,
      'slikaFilePath': instance.SlikaFile,
    };
