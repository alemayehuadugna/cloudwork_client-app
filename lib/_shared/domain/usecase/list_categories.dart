import 'package:dartz/dartz.dart';

import '../../../_core/error/failures.dart';
import '../../../_core/usecase.dart';
import '../entities/category.dart';
import '../repo/category_repository.dart';

class ListCategory implements UseCase<List<Category>, NoParams> {
  final CategoryRepository repository;

  ListCategory ({required this.repository});

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.listCategories();
  }
}
