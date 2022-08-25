import 'package:get_it/get_it.dart';

import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/review_repository_impl.dart';
import 'domain/repo/review_repository.dart';
import 'domain/usecases/give_review.dart';
import 'domain/usecases/list_review.dart';
import 'views/bloc/give_review_bloc/give_review_bloc.dart';
import 'views/bloc/list_review_bloc/list_review_bloc.dart';

void injectReview(GetIt container) {
  //! Data Source Injection
  container.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(dio: container()),
  );
  container.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(
      remoteDataSource: container(),
    ),
  );

  //! Usecase Injection
  container.registerLazySingleton(() => ListReviewUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => GiveReviewUseCase(
        repository: container(),
      ));

  //! Bloc Injection
  container.registerFactory(() => GiveReviewBloc(
        giveReviewUseCase: container(),
      ));
  container.registerFactory(() => ListReviewBloc(
        listReviewUseCase: container(),
      ));
}
