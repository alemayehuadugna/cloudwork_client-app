import 'package:clean_flutter/modules/favorites/data/data_sources/local_data_source.dart';
import 'package:clean_flutter/modules/favorites/data/data_sources/remote_data_source.dart';
import 'package:clean_flutter/modules/favorites/data/repositories/favorite_freelancer_repo_impl.dart';
import 'package:clean_flutter/modules/favorites/domain/repo/favorite_freelancer_repository.dart';
import 'package:clean_flutter/modules/favorites/domain/usecase/get_favorite_freelancers.dart';
import 'package:clean_flutter/modules/favorites/views/bloc/favorite_freelancers_bloc.dart';
import 'package:get_it/get_it.dart';

void injectFavoriteFreelancers(GetIt container) {
  //!Data source injection
  container.registerLazySingleton<FavoriteFreelancerRemoteDataSource>(
    () => FavoriteFreelancerRemoteDataSourceImpl(dio: container()),
  );

  container.registerLazySingleton<FavoriteFreelancerLocalDataSources>(
      () => FavoriteFreelancerLocalDataSourcesImpl(hive: container()));

  //!Repository injection
  container.registerLazySingleton<FavoriteFreelancerRepository>(() =>
      FavoriteFreelancersRepositoryImpl(
          remoteDataSource: container(), localDataSources: container()));

  //! usecase injection
  container.registerLazySingleton<GetFavoriteFreelancersUsecase>(
      () => GetFavoriteFreelancersUsecase(repository: container()));

  //! bloc injection
  container.registerFactory(() =>
      FavoriteFreelancersBloc(getFavoriteFreelancersUsecase: container()));
}
