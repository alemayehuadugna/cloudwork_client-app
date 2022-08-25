import 'package:equatable/equatable.dart';

import '../domain/entities/job.dart';

JobProposalEntity? proposalJob;
JobDetailEntity? detailJob;
int buildCount= 0;

class JobParams extends Equatable {
  final String id;

  const JobParams({required this.id});

  @override 
  List<Object?> get props => [id];
}

class PaginationParams extends Equatable {
  final int pageKey; 
  final int pageSize;
  final String clientId;

  const PaginationParams(this.pageKey, this.pageSize, this.clientId);
  
  @override
  List<Object?> get props => [pageKey, pageSize];

}
