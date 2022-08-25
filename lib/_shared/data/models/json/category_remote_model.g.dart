// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRemoteModel _$CategoryRemoteModelFromJson(Map<String, dynamic> json) =>
    CategoryRemoteModel(
      categoryName: json['categoryName'] as String,
      subCategory: (json['subCategory'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CategoryRemoteModelToJson(
        CategoryRemoteModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'subCategory': instance.subCategory,
    };
