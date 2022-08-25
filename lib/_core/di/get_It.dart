// ignore_for_file: file_names

import 'package:clean_flutter/_core/dio_config.dart';
import 'package:clean_flutter/modules/alerts/injection.dart';
import 'package:clean_flutter/modules/chat/injection.dart';
import 'package:clean_flutter/modules/client-job/injection.dart';
import 'package:clean_flutter/modules/favorites/injection.dart';
import 'package:clean_flutter/modules/freelancer/injection.dart';
import 'package:clean_flutter/modules/payments/injection.dart';
import 'package:clean_flutter/modules/review/injection.dart';
import 'package:clean_flutter/modules/settings/injection.dart';
import 'package:clean_flutter/modules/user/injection.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../_shared/injection.dart';
import '../hive_config.dart';
import '../socket_config.dart';

final container = GetIt.instance;

Future<void> init() async {
  //! Core
  await HiveConfig.init();
  final Dio dio = await DioConfig.init();
  final HiveInterface hive = Hive;
  final Socket socket = initSocket();
  container.registerLazySingleton(() => socket);
  container.registerLazySingleton(() => dio);
  container.registerLazySingleton(() => hive);

  //! injection of user module
  injectUsers(container);
  injectSetting(container);

  //! injection of client job module
  injectJobs(container);

  //! injection of category
  injectCategory(container);

  //! injection of Freelancer module
  injectFreelancers(container);

  //! injection of favorite freelancers
  injectFavoriteFreelancers(container);

  //! injection of payment module
  injectPayments(container);

  //! injection of chat module
  injectChat(container);

  //! injection of alert module
  injectAlert(container);

  //! injection of review module
  injectReview(container);
}
