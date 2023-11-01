// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_zauzeti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminZauzeti _$TerminZauzetiFromJson(Map<String, dynamic> json) =>
    TerminZauzeti(
      json['terminId'] as int,
      DateTime.parse(json['terminVrijeme'] as String),
    );

Map<String, dynamic> _$TerminZauzetiToJson(TerminZauzeti instance) =>
    <String, dynamic>{
      'terminId': instance.terminId,
      'terminVrijeme': instance.terminVrijeme.toIso8601String(),
    };
