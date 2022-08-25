import 'package:json_annotation/json_annotation.dart';

part 'category_remote_model.g.dart';

@JsonSerializable()
class CategoryRemoteModel {
  final String categoryName;
  final List<String> subCategory;

  CategoryRemoteModel({
    required this.categoryName,
    required this.subCategory,
  });

  factory CategoryRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$CategoryRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$CategoryRemoteModelToJson(this);
  }
}
