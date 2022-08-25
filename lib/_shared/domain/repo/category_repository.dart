import 'package:clean_flutter/_shared/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

import '../../../_core/error/failures.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> listCategories();
}