// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordinacija_pacijent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdinacijaPacijent _$OrdinacijaPacijentFromJson(Map<String, dynamic> json) =>
    OrdinacijaPacijent(
      json['ordinacijaId'] as int,
      json['ordinacijaNaziv'] as String,
      json['ordinacijaAdresa'] as String,
    );

Map<String, dynamic> _$OrdinacijaPacijentToJson(OrdinacijaPacijent instance) =>
    <String, dynamic>{
      'ordinacijaId': instance.ordinacijaId,
      'ordinacijaNaziv': instance.ordinacijaNaziv,
      'ordinacijaAdresa': instance.ordinacijaAdresa,
    };
