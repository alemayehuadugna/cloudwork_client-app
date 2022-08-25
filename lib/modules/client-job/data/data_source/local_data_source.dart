import 'dart:convert';

import 'package:clean_flutter/_core/error/exceptions.dart';
import 'package:clean_flutter/modules/client-job/data/models/hive/job_hive_model.dart';
import 'package:clean_flutter/modules/client-job/data/models/json/job_remote_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class JobLocalDataSource {
  Future<void> cacheJobs(List<JobRemoteModel> jobToCache);
  Future<List<JobHiveModel>> listCachedJobs();

  Future<void> cacheJob(JobDetailRemoteModel jobToCache);
  Future<JobDetailHiveModel> getJob();

  Future<void> cachePendingJobs(List<JobRemoteModel> jobToCache);
  Future<List<JobHiveModel>> listCachedPendingJobs();

  Future<void> cacheEditedJob(JobRemoteModel jobToCache);
  Future<JobHiveModel> getEditedJob();

  Future<void> cacheProposals(JobProposalRemoteModel proposalToCache);
  Future<JobProposalHiveModel> getProposals();

  Future<void> cacheOngoingJobs(List<JobRemoteModel> jobToCache);
  Future<List<JobHiveModel>> listCachedOngoingJobs();

  Future<void> cacheCompletedJobs(List<JobRemoteModel> jobToCache);
  Future<List<JobHiveModel>> listCachedCompletedJobs();

  Future<void> cacheCanceledJobs(List<JobRemoteModel> jobToCache);
  Future<List<JobHiveModel>> listCachedCanceledJobs();
}

class JobLocalDataSourceImpl implements JobLocalDataSource {
  final HiveInterface hive;

  JobLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheJobs(List<JobRemoteModel> jobToCache) async {
    try {
      var data = [];
      jobToCache.forEach((element) {
        data.add(json.encode(element.toJson()));
      });
      var jobBox = await hive.openBox('job');
      jobBox.put("cachedJob", data);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<JobHiveModel>> listCachedJobs() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("cachedJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheJob(JobDetailRemoteModel jobToCache) async {
    try {
      var jobBox = await hive.openBox('job');
      jobBox.put("cachedDetailJob", jobToCache);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<JobDetailHiveModel> getJob() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("cachedDetailJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePendingJobs(List<JobRemoteModel> jobToCache) async {
    try {
      var data = [];
      jobToCache.forEach((element) {
        data.add(json.encode(element.toJson()));
      });
      var jobBox = await hive.openBox('job');
      jobBox.put("pendingJob", data);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<JobHiveModel>> listCachedPendingJobs() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("pendingJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheEditedJob(JobRemoteModel jobToCache) async {
    try {
      var jobBox = await hive.openBox('job');
      jobBox.put("cachedEditedJob", jobToCache);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<JobHiveModel> getEditedJob() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("cachedEditJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProposals(JobProposalRemoteModel proposalToCache) async {
    try {
      var jobBox = await hive.openBox('job');
      jobBox.put("cachedProposals", proposalToCache);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<JobProposalHiveModel> getProposals() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("cachedProposals");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheOngoingJobs(List<JobRemoteModel> jobToCache) async {
    try {
      var data = [];
      jobToCache.forEach((element) {
        data.add(json.encode(element.toJson()));
      });
      var jobBox = await hive.openBox('job');
      jobBox.put("ongoingJob", data);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<JobHiveModel>> listCachedOngoingJobs() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("ongoingJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCompletedJobs(List<JobRemoteModel> jobToCache) async {
    try {
      var data = [];
      jobToCache.forEach((element) {
        data.add(json.encode(element.toJson()));
      });
      var jobBox = await hive.openBox('job');
      jobBox.put("completedJob", data);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<JobHiveModel>> listCachedCompletedJobs() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("completedJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCanceledJobs(List<JobRemoteModel> jobToCache) async {
    try {
      var data = [];
      jobToCache.forEach((element) {
        data.add(json.encode(element.toJson()));
      });
      var jobBox = await hive.openBox('job');
      jobBox.put("cancelledJob", data);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<JobHiveModel>> listCachedCanceledJobs() async {
    final jobBox = await hive.openBox('job');
    final cachedData = jobBox.get("cancelledJob");
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }
}
