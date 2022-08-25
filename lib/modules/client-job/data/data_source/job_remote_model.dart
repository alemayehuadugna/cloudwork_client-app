import 'dart:io';

import 'package:clean_flutter/_shared/data/mappers/result_page_mapper.dart';
import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/data/mappers/job_mapper.dart';
import 'package:clean_flutter/modules/client-job/data/models/json/job_remote_model.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/hire_freelancer.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';

import '../../../../_core/cqrs.dart';
import '../../domain/usecase/addMilestone.dart';
import '../../domain/usecase/changeProgress.dart';
import '../../domain/usecase/deleteJob.dart';
import '../../domain/usecase/payFreelancer.dart';

abstract class JobRemoteDataSource {
  Future<List<JobRemoteModel>> listJobs(PaginationParams params);
  Future<JobDetailRemoteModel> getJob(JobParams params);
  Future<List<JobRemoteModel>> pendingJob(PaginationParams params);
  Future<JobDetailRemoteModel> editJob(JobDetailEntity params);
  Future<JobProposalRemoteModel> viewProposals(JobParams params);
  Future<JobDetailRemoteModel> postJob(JobDetailEntity params);
  Future<List<JobRemoteModel>> ongoingJob(PaginationParams params);
  Future<List<JobRemoteModel>> completedJob(PaginationParams params);
  Future<List<JobRemoteModel>> canceledJob(PaginationParams params);
  Future<JobIdRemoteModel> changeProgress(ProgressParams params);
  Future<JobIdRemoteModel> hireFreelancer(HireParams params);
  Future<PaginatedQueryResult<List<MilestoneRemoteModel>>> listMilestones(
      {pagination, filter, sort, jobId, type});
  Future<JobIdRemoteModel> payFreelancer(PaymentParams params);
  Future<String> deleteJob(DeleteJobParams params);
  Future<String> addMilestone(AddMilestoneParams params);
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final Dio dio;

  JobRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<JobRemoteModel>> listJobs(PaginationParams params) async {
    String path = "/jobs/user/${params.clientId}";
    var pagination = {'page': params.pageKey, 'limit': params.pageSize};
    final response = await dio.get(path, queryParameters: pagination);
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<JobDetailRemoteModel> getJob(JobParams params) async {
    final response = await dio.get('/jobs/${params.id}');
    // print("detail: $response");
    return JobMapper.detailFromJson(response.data['data']);
  }

  @override
  Future<List<JobRemoteModel>> pendingJob(PaginationParams params) async {
    String path = "/jobs/user/${params.clientId}";
    var filter = const FilterRemoteModel('INACTIVE').toJson();

    final response = await dio.get(path, queryParameters: {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    });
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<JobDetailRemoteModel> editJob(JobDetailEntity params) async {
    final upload = params.files as List<PlatformFile>;
    List<MultipartFile> filesToUpload = [];

    final data = {
      'clientId': params.clientId,
      'title': params.title,
      'skills': params.skills,
      'budget': params.budget,
      'duration': params.duration,
      'expiry': params.expiry,
      'category': params.category,
      'language': params.language,
      'links': params.links,
      'description': params.description
    };
    final response = await dio.patch('/update/job/${params.id}', data: data);

    JobDetailRemoteModel mappedData =
        JobMapper.detailFromJson(response.data['data']);
    // var id = mappedData.id;

    // if (mappedData.id.isNotEmpty) {
    //   for (PlatformFile file in upload) {
    //     if (kIsWeb) {
    //       filesToUpload.add(MultipartFile.fromBytes(
    //         file.bytes!,
    //         filename: file.name,
    //         contentType: MediaType('image', file.extension!),
    //       ));
    //     } else {
    //       final fileBytes = await File(file.path!).readAsBytes();
    //       filesToUpload.add(MultipartFile.fromBytes(
    //         fileBytes,
    //         filename: file.name,
    //         contentType: MediaType('image', file.extension!),
    //       ));
    //     }
    //   }

    //   final formData = FormData.fromMap({'files': filesToUpload});
    //   await dio.patch('/jobs/files/$id', data: formData);
    // }
    return mappedData;
  }

  @override
  Future<JobProposalRemoteModel> viewProposals(JobParams params) async {
    final response = await dio.patch('/list/bids/${params.id}');

    return JobMapper.proposalFromJson(response.data['data']);
  }

  @override
  Future<JobDetailRemoteModel> postJob(JobDetailEntity params) async {
    final upload = params.files as List<PlatformFile>;
    List<MultipartFile> filesToUpload = [];

    final data = {
      'clientId': params.clientId,
      'title': params.title,
      'skills': params.skills,
      'budget': params.budget,
      'duration': params.duration,
      'expiry': params.expiry,
      'category': params.category,
      'language': params.language,
      'links': params.links,
      'description': params.description
    };
    var response = await dio.post('/jobs', data: data);
    JobDetailRemoteModel mappedData =
        JobMapper.detailFromJson(response.data['data']);
    var id = mappedData.id;

    if (mappedData.id.isNotEmpty) {
      for (PlatformFile file in upload) {
        if (kIsWeb) {
          filesToUpload.add(MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
            contentType: MediaType('image', file.extension!),
          ));
        } else {
          final fileBytes = await File(file.path!).readAsBytes();
          filesToUpload.add(MultipartFile.fromBytes(
            fileBytes,
            filename: file.name,
            contentType: MediaType('image', file.extension!),
          ));
        }
      }

      final formData = FormData.fromMap({'files': filesToUpload});
      await dio.patch('/jobs/files/$id', data: formData);
    }
    return mappedData;
  }

  @override
  Future<List<JobRemoteModel>> ongoingJob(PaginationParams params) async {
    String path = "/jobs/user/${params.clientId}";
    var filter = const FilterRemoteModel('ACTIVE').toJson();
    final response = await dio.get(path, queryParameters: {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    });
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<List<JobRemoteModel>> completedJob(PaginationParams params) async {
    String path = "/jobs/user/${params.clientId}";
    var filter = const FilterRemoteModel('COMPLETED').toJson();
    final response = await dio.get(path, queryParameters: {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    });
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<List<JobRemoteModel>> canceledJob(PaginationParams params) async {
    String path = "/jobs/user/${params.clientId}";
    var filter = const FilterRemoteModel('CANCELLED').toJson();

    final response = await dio.get(path, queryParameters: {
      'page': params.pageKey,
      'limit': params.pageSize,
      'filter': filter
    });
    final data = <JobRemoteModel>[];
    response.data['data'].forEach((item) {
      data.add(JobMapper.fromJson(item));
    });
    return data;
  }

  @override
  Future<JobIdRemoteModel> changeProgress(ProgressParams params) async {
    final data = {
      'progress': params.progress,
      'freelancerId': params.freelancerId,
      'clientId': params.clientId
    };
    final response =
        await dio.patch('/update/progress/${params.id}', data: data);
    return JobMapper.jobIdFromJson(response.data);
  }

  @override
  Future<JobIdRemoteModel> hireFreelancer(HireParams params) async {
    final data = {
      'freelancerId': params.freelancerId,
      'clientId': params.clientId,
      'amount': params.amount
    };
    final response = await dio.patch('/jobs/hire/${params.id}', data: data);
    return JobMapper.jobIdFromJson(response.data);
  }

  @override
  Future<PaginatedQueryResult<List<MilestoneRemoteModel>>> listMilestones(
      {pagination, filter, sort, jobId, type}) async {
    final data = {'type': type};
    final response = await dio.patch('/list/milestones/$jobId',
        queryParameters: pagination, data: data);
    final remoteData = <MilestoneRemoteModel>[];
    response.data['data'].forEach((item) {
      remoteData.add(JobMapper.milestoneFromJson(item));
    });
    return PaginatedQueryResult(
      data: remoteData,
      page: ResultPageMapper.fromJson(response.data['page']),
    );
  }

  @override
  Future<JobIdRemoteModel> payFreelancer(PaymentParams params) async {
    final data = {
      'milestoneId': params.milestoneId,
      'freelancerId': params.freelancerId,
      'clientId': params.clientId,
      'amount': params.amount
    };
    final response =
        await dio.patch('/jobs/payFreelancer/${params.jobId}', data: data);
    return JobMapper.jobIdFromJson(response.data);
  }

  @override
  Future<String> deleteJob(DeleteJobParams params) async {
    final data = {
      'freelancerId': params.freelancerId,
      'clientId': params.clientId,
    };
    await dio.delete('/jobs/${params.id}', data: data);
    return "Success";
  }

  @override
  Future<String> addMilestone(AddMilestoneParams params) async {
    final data = {
      'name': params.name,
      'budget': params.budget,
      'startDate': params.startDate,
      'endDate': params.endDate,
      'description': params.description,
    };
    print("jobId: ${params.jobId}");
    var response = await dio.patch(
        '/add/milestone/${params.jobId}',
        data: data);
    return "Success";
  }
}
