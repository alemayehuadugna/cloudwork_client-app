import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/views/job_detail/blocs/get_job_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_detail/widgets/get_job_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';

import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../common/constant.dart';
import '../../../domain/entities/job.dart';

class JobDetailPage extends StatelessWidget {
  final String? id;
  final String? kind;
  final String? tabKind;
  const JobDetailPage({
    Key? key,
    required this.id,
    required this.kind,
    required this.tabKind,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobDetailBloc, JobDetailState>(
        listener: ((context, state) {
      if (state is JobDetailLoading) {
        context.loaderOverlay.show();
      } else if (state is ErrorLoadingJobDetail) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is JobDetailLoaded) {
        permanentJob ??= state.job;
        detailJob = state.job;
        context.loaderOverlay.hide();
      } else if (state is PayFreelancerLoading) {
        context.loaderOverlay.show();
      } else if (state is PayFreelancerLoaded) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Paying Freelancer'),
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
                    const Text("Payment Successful"),
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
        BlocProvider.of<JobDetailBloc>(context).add(
          ListMilestonesEvent(
              pagination: const {'page': 1, 'limit': 10},
              jobId: id!,
              type: 'all'),
        );
      } else if (state is ErrorLoadingPayFreelancer) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is ChangeJobProgressLoaded) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Changing Job Status'),
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
                    const Text("Job Status Changed SuccessFully"),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.loaderOverlay.hide();
                    context.pop();
                  },
                ),
              ],
            );
          },
        );

        BlocProvider.of<JobDetailBloc>(context).add(GetJobEvent(id: id!));
      } else if (state is ErrorLoadingChangeJobProgress) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      }
    }), builder: ((context, state) {
      if (state is JobDetailInitial) {
        var _jobDetailBloc = BlocProvider.of<JobDetailBloc>(context);
        _jobDetailBloc.add(GetJobEvent(id: id!));
      }
      if (state is JobDetailLoaded ||
          state is ChangeJobProgressLoaded ||
          GoRouter.of(context).location == '/jobs/all/details/$id/milestones' ||
          GoRouter.of(context).location == '/jobs/all/details/$id/payments') {
        if ((GoRouter.of(context).location ==
                    '/jobs/all/details/$id/milestones' &&
                state is JobDetailLoaded) ||
            (GoRouter.of(context).location ==
                    '/jobs/all/details/$id/payments' &&
                state is JobDetailLoaded)) {
          BlocProvider.of<JobDetailBloc>(context).emit(MilestoneInitial());
        }
        return detailJob == null
            ? Scaffold(
                appBar: AppBar(title: const Text('Job Detail Page')),
                body: const Center(child: Text("")),
              )
            : Scaffold(
                appBar: AppBar(title: const Text('Job Detail Page')),
                body: SingleChildScrollView(
                  child: JobDetailDisplay(
                      kind: kind!, tabKind: tabKind!, job: detailJob!),
                ),
              );
      } else {
        initial = 0;
        BlocProvider.of<JobDetailBloc>(context).emit(JobDetailInitial());
        return Scaffold(
          appBar: AppBar(title: const Text('Job Detail Page')),
          body: const Center(child: Text("")),
        );
      }
    }));
  }
}
