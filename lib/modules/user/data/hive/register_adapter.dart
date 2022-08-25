import 'package:clean_flutter/_shared/data/models/hive/common_model.dart';
import 'package:clean_flutter/modules/user/data/hive/basic_local_user.dart';
import 'package:clean_flutter/modules/user/data/hive/detail_local_user.dart';
import 'package:hive/hive.dart';

class UserAdapter {
  static void registerUserAdapter() {
    Hive.registerAdapter(BasicLocalUserAdapter());
    Hive.registerAdapter(DetailLocalUserAdapter());
    Hive.registerAdapter(RatingModelAdapter());
  }
}
