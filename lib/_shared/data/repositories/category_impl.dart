import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../_core/error/failures.dart';
import '../../domain/entities/category.dart';
import '../../domain/repo/category_repository.dart';
import '../data_source/category_remote_model.dart';
import '../mappers/category_mapper.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> listCategories() async {
    try {
      final remoteCategory = await remoteDataSource.listCategories();
      return Right(CategoryMapper.toEntity(remoteCategory));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }
}
