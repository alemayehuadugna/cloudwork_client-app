import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const pageSize = 10;
var pageKey;

 PagingController<int, JobEntity> pagingController =
    PagingController(firstPageKey: 1);

int count = 0;
