import 'package:clean_flutter/modules/freelancer/data/repositories/freelancer_repository_impl.dart';
import 'package:clean_flutter/modules/freelancer/domain/entities/freelancer_detail.dart';
import 'package:clean_flutter/modules/freelancer/domain/repo/freelancer_repository.dart';
import 'package:clean_flutter/modules/freelancer/domain/usecases/get_freelancer_detail.dart';
import 'package:clean_flutter/modules/freelancer/views/detail/bloc/freelancer_detail_bloc.dart';
import 'package:get_it/get_it.dart';

import 'common/bloc/filter_freelancer_menu_cubit.dart';
import 'data/data_source/remote_data_source.dart';
import 'domain/usecases/list_freelancer.dart';
import 'views/list/bloc/list_freelancer_bloc.dart';

void injectFreelancers(GetIt container) {
  //! Data Source Injection
  container.registerLazySingleton<FreelancerRemoteDataSource>(
    () => FreelancerRemoteDataSourceImpl(dio: container()),
  );
  container.registerLazySingleton<FreelancerRepository>(
    () => FreelancerRepositoryImpl(
      remoteDataSource: container(),
    ),
  );

  //! Usecase Injection
  container.registerLazySingleton(() => ListFreelancersUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => GetFreelancerDetailUseCase(
        repository: container(),
      ));

  //! Bloc Injection
  container.registerFactory(() => ListFreelancerBloc(
        listFreelancers: container(),
      ));
  container.registerFactory(() => FreelancerDetailBloc(
        getFreelancerDetailUseCase: container(),
      ));
  container.registerLazySingleton(() => FilterFreelancerMenuCubit());
}
