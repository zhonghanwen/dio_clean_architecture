// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestModel _$TestModelFromJson(Map<String, dynamic> json) {
  return TestModel(json['phone'] as String, json['pre_register'] as int);
}

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'phone': instance.phone,
      'pre_register': instance.pre_register
    };
