import 'package:dio/dio.dart';

import '../mappers/category_mapper.dart';
import '../models/json/category_remote_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryRemoteModel>> listCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoryRemoteModel>> listCategories() async {
    final response = await dio.get('/categories');
    final data = <CategoryRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(CategoryMapper.fromJson(item));
    });

    return data;
  }
}
