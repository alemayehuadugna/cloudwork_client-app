import 'package:clean_flutter/modules/user/data/mappers/basic_user_mapper.dart';
import 'package:clean_flutter/modules/user/data/mappers/detail_user_mapper.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<BasicUser> getBasicUser();

  Future<DetailUser> getDetailUser();

  Future<String> authenticate(String phone, String password);

  Future<String> register(payload);

  Future<String> verifyEmail(String code, String email);

  Future<String> verifyForgetEmail(String code, String email);

  Future<void> resendOTP(String email, String type);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> authenticate(String email, String password) async {
    String path = "/clients/login";
    final data = {'email': email, 'password': password};
    final response = await dio.post(path, data: data);
    return response.data;
  }

  @override
  Future<BasicUser> getBasicUser() async {
    String path = '/clients/me/basic';
    final response = await dio.get(path);
    return BasicUserMapper.fromJson(response.data);
  }

  @override
  Future<String> register(payload) async {
    String path = '/clients';
    final response = await dio.post(path, data: payload);
    return response.data['id'];
  }

  @override
  Future<String> verifyEmail(String code, String email) async {
    String path = '/clients/me/verify/email';
    final response = await dio.post(path, data: {'code': code, 'email': email});

    return response.data['token'];
  }

  @override
  Future<String> verifyForgetEmail(String code, String email) async {
    String path = '/clients/me/verify/email';
    final response = await dio.post(path, data: {'code': code, 'email': email});

    return response.data['token'];
  }

  @override
  Future<void> resendOTP(String email, String type) async {
    String path =
        type == "Forget" ? '/clients/forgotPassword' : '/clients/me/send/otp';
    print("email is here");
    print(email);
    await dio.post(path, data: {'email': email});
    return;
  }

  @override
  Future<DetailUser> getDetailUser() async {
    String path = '/clients/me/detail';
    final response = await dio.get(path);
    print("Detail user");
    print(response);
    DetailUser user = DetailUserMapper.fromJson(response.data);

    print(user);
    return DetailUserMapper.fromJson(response.data);
  }
}
