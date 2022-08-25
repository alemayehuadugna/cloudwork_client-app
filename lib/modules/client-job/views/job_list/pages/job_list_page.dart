import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../common/constant.dart';
import '../../../common/pagination.dart';
import '../../../domain/entities/job.dart';
import '../bloc/list_job_bloc.dart';
import '../widgets/list_job_display.dart';

class JobListPage extends StatefulWidget {
  final String? kind;
  const JobListPage({
    Key? key,
    required this.kind,
  }) : super(key: key);

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageKey = 0;
    if (GoRouter.of(context).location == '/jobs/all') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListJobInSubmitted(
          pageKey: 0, pageSize: pageSize, clientId: clientId!));
    } else if (GoRouter.of(context).location == '/jobs/pending') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListPendingJobInSubmitted(
          pageKey: 0, pageSize: pageSize, clientId: clientId!));
    } else if (GoRouter.of(context).location == '/jobs/ongoing') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListOngoingJobInSubmitted(
          pageKey: 0, pageSize: pageSize, clientId: clientId!));
    } 
    else if (GoRouter.of(context).location == '/jobs/completed') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListCompletedJobInSubmitted(
          pageKey: 0, pageSize: pageSize, clientId: clientId!));
    } else if (GoRouter.of(context).location == '/jobs/canceled') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListCanceledJobInSubmitted(
          pageKey: 0, pageSize: pageSize, clientId: clientId!));
    }
    return BlocConsumer<ListJobBloc, ListJobState>(
      listener: ((context, state) {
        // List<JobEntity> jobs = [];    
        if (state is ListJobLoaded) {
          context.loaderOverlay.hide();
          if (count != 0) {
            if (pagingController.itemList != null) {
              pagingController.itemList = null;
            }
            count = 0;
          }
          final isLastPage = state.job.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(state.job);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(state.job, nextPageKey);
          }
        } else if (state is ListPendingJobLoaded) {
          if (count != 0) {
            if (pagingController.itemList != null) {
              pagingController.itemList = null;
            }
            count = 0;
          }
          final isLastPage = state.pendingJob.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(state.pendingJob);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(state.pendingJob, nextPageKey);
          }
        } 
        else if (state is ListOngoingJobLoaded) {
          if (count != 0) {
            if (pagingController.itemList != null) {
              pagingController.itemList = null;
            }
            count = 0;
          }
          final isLastPage = state.ongoingJob.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(state.ongoingJob);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(state.ongoingJob, nextPageKey);
          }
        } else if (state is ListCompletedJobLoaded) {
          if (count != 0) {
            if (pagingController.itemList != null) {
              pagingController.itemList = null;
            }
            count = 0;
          }
          final isLastPage = state.completedJob.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(state.completedJob);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(state.completedJob, nextPageKey);
          }
        } else if (state is ListCanceledJobLoaded) {
          if (count != 0) {
            if (pagingController.itemList != null) {
              pagingController.itemList = null;
            }
            count = 0;
          }
          final isLastPage = state.canceledJob.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(state.canceledJob);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(state.canceledJob, nextPageKey);
          }
        } else if (state is ErrorLoadingListJob) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        } else if (state is ErrorLoadingListPendingJob) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        } 
        else if (state is ErrorLoadingListOngoingJob) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        } else if (state is ErrorLoadingListCompletedJob) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        } else if (state is ErrorLoadingListCanceledJob) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        } 
        else if (state is DeleteJobLoaded) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Deleting Job'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          height: 200,
                          width: ResponsiveValue<double>(context,
                                  defaultValue: 400,
                                  valueWhen: const [
                                    Condition.smallerThan(
                                        name: TABLET, value: 300)
                                  ]).value ??
                              400,
                          child: SvgPicture.asset(
                            "assets/icons/completed.svg",
                          ),
                        ),
                      ),
                      const Text("Job Deleted SuccessFully"),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.loaderOverlay.hide();
                    },
                  ),
                ],
              );
            },
          );

          pagingController.itemList = null;
          BlocProvider.of<ListJobBloc>(context).add(ListJobInSubmitted(
              pageKey: 0, pageSize: pageSize, clientId: clientId!));
        } else if (state is ErrorLoadingDeleteJob) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        }
      }),
      builder: ((context, state) {
        return ListJobDisplay(kind: widget.kind!);
      }),
    );
  
  }

  Future<void> _fetchPage(int pagekey) async {
    pageKey = pagekey;
    try {
      if (widget.kind == 'all') {
        BlocProvider.of<ListJobBloc>(context).add(ListJobInSubmitted(
            pageKey: pagekey, pageSize: pageSize, clientId: clientId!));
      } else if (widget.kind == 'pending') {
        BlocProvider.of<ListJobBloc>(context).add(ListPendingJobInSubmitted(
            pageKey: pagekey, pageSize: pageSize, clientId: clientId!));
      } else if (widget.kind == 'ongoing') {
        BlocProvider.of<ListJobBloc>(context).add(ListOngoingJobInSubmitted(
            pageKey: pagekey, pageSize: pageSize, clientId: clientId!));
      } else if (widget.kind == 'completed') {
        BlocProvider.of<ListJobBloc>(context).add(ListCompletedJobInSubmitted(
            pageKey: pagekey, pageSize: pageSize, clientId: clientId!));
      } else if (widget.kind == 'canceled') {
        BlocProvider.of<ListJobBloc>(context).add(ListCanceledJobInSubmitted(
            pageKey: pagekey, pageSize: pageSize, clientId: clientId!));
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}