import 'dart:io';
import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/domain/entities/social_link.dart';
import 'package:clean_flutter/modules/user/data/json/detail_remote_user.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

abstract class SettingRemoteDataSource {
  Future<String> changePassword(String oldPassword, String newPassword);

  Future<String> uploadProfilePicture(final file);

  Future<String> updateBasicProfile(
      String firstName, String lastName, String email, String phone);

  Future<String> updateAddress(Address address);

  Future<String> updateDescription(String description);

  Future<String> updateOverview(String companyName, String websiteUrl);

  Future<String> updateSocialLinks(List<SocialLink> socialLinks);

  Future<String> deleteAccount(String reason, String password);

  Future<String> feedback(
      String firstName, String lastName, String message, String title);

  Future<String> resetPassword(String email, String password);
}

class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  final Dio dio;

  SettingRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> changePassword(String oldPassword, String newPassword) async {
    String path = '/clients/me/changePassword';
    final inputData = {'oldPassword': oldPassword, 'newPassword': newPassword};
    final response = await dio.patch(path, data: inputData);

    return response.data['clientId'];
  }

  @override
  Future<String> uploadProfilePicture(final file) async {
    String path = '/clients/me/profilePicture';
    final upload = file as PlatformFile;
    MultipartFile fileToUpload;
    if (kIsWeb) {
      fileToUpload = MultipartFile.fromBytes(
        upload.bytes!,
        filename: upload.name,
        contentType: MediaType('image', upload.extension!),
      );
    } else {
      final fileBytes = await File(upload.path!).readAsBytes();
      fileToUpload = MultipartFile.fromBytes(fileBytes,
          filename: upload.name,
          contentType: MediaType('image', upload.extension!));
    }

    final formData = FormData.fromMap({'profilePicture': fileToUpload});
    final response = await dio.patch(path, data: formData);

    return response.data['data'];
  }

  @override
  Future<String> updateBasicProfile(
      String firstName, String lastName, String email, String phone) async {
    String path = '/clients/me/basic';

    final inputData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone
    };

    final response = await dio.patch(path, data: inputData);
    return response.data['clientId'];
  }

  @override
  Future<String> updateDescription(String description) async {
    String path = "/clients/me/updateDescription";

    final inputData = {'description': description};

    final response = await dio.patch(path, data: inputData);

    return response.data['clientId'];
  }

  @override
  Future<String> updateOverview(String companyName, String websiteUrl) async {
    String path = "/clients/me/updateProfileOverview";

    final inputData = {'companyName': companyName, 'websiteUrl': websiteUrl};

    final response = await dio.patch(path, data: inputData);

    return response.data['clientId'];
  }

  @override
  Future<String> updateAddress(Address address) async {
    String path = "/clients/me/updateAddress";

    final newAddress = AddressRemoteModel(
            address.region, address.city, address.areaName, address.postalCode)
        .toJson();
    final response = await dio.patch(path, data: newAddress);

    return response.data['clientId'];
  }

  @override
  Future<String> updateSocialLinks(List<SocialLink> links) async {
    String path = "/clients/me/updateSocialLinks";
    List socialLinks = [];
    for (int i = 0; i < links.length; i++) {
      socialLinks.add(
          SocialLinkRemoteModel(links[i].socialMedia, links[i].link).toJson());
    }

    final response = await dio.patch(path, data: socialLinks);

    return response.data['clientId'];
  }

  @override
  deleteAccount(String reason, String password) async {
    String path = "/clients/me/delete";
    final response = await dio.delete(
      path,
      data: {"reason": reason, "password": password},
    );
    return response.data['clientId'];
  }

  @override
  Future<String> feedback(
      String firstName, String lastName, String message, String title) async {
    String path = "/feedbacks";
    final response = await dio.post(path, data: {
      "firstName": firstName,
      "lastName": lastName,
      "message": message,
      "title": title
    });

    return response.data['id'];
  }

  @override
  Future<String> resetPassword(String email, String password) async {
    String path = '/clients/resetPassword';

    final response =
        await dio.patch(path, data: {"email": email, "password": password});

    return response.data['clientId'];
  }
}
