import 'package:clean_flutter/_shared/data/mappers/result_page_mapper.dart';
import 'package:clean_flutter/modules/freelancer/data/mapper/freelancer_detail_mapper.dart';
import 'package:clean_flutter/modules/freelancer/domain/entities/freelancer_detail.dart';
import 'package:dio/dio.dart';

import '../../../../_core/cqrs.dart';
import '../../domain/entities/freelancer_basic.dart';
import '../mapper/freelancer_basic_mapper.dart';

abstract class FreelancerRemoteDataSource {
  Future<PaginatedQueryResult<List<FreelancerBasic>>> listFreelancerBasic(
      {pagination, filter, sort});
  Future<FreelancerDetail> getFreelancerDetail(String id);
}

class FreelancerRemoteDataSourceImpl implements FreelancerRemoteDataSource {
  final Dio dio;

  FreelancerRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedQueryResult<List<FreelancerBasic>>> listFreelancerBasic(
      {pagination, filter, sort}) async {
    const path = "/freelancers";
    final response = await dio.get(path, queryParameters: pagination);
    return PaginatedQueryResult(
      data: FreelancerBasicMapper.fromJson(response.data['data']),
      page: ResultPageMapper.fromJson(response.data['page']),
    );
  }

  @override
  Future<FreelancerDetail> getFreelancerDetail(String id) async {
    String path = '/freelancers/$id';
    final response = await dio.get(path);
    // print("response: $response['data']");
    return FreelancerDetailMapper.fromJosn(response.data['data']);
  }
}
