import 'package:clean_flutter/_shared/data/data_source/category_remote_model.dart';
import 'package:clean_flutter/_shared/data/repositories/category_impl.dart';
import 'package:clean_flutter/_shared/domain/repo/category_repository.dart';
import 'package:clean_flutter/_shared/domain/usecase/list_categories.dart';
import 'package:clean_flutter/_shared/interface/bloc/category/list_bloc/list_category_bloc.dart';
import 'package:get_it/get_it.dart';

void injectCategory(GetIt container) {
  //! Bloc Injection
  container.registerFactory(() => ListCategoryBloc(listCategory: container()));

  //! Data Source Injection
  container.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(dio: container()));
  container.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: container()));

  //! Use Case Injection
  container.registerLazySingleton(() => ListCategory(repository: container()));
}
