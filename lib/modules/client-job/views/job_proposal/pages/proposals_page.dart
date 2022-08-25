import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/views/job_proposal/bloc/proposal_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_proposal/widgets/loading_Widget.dart';
import 'package:clean_flutter/modules/client-job/views/job_proposal/widgets/proposals_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../common/params.dart';

class ProposalsPage extends StatelessWidget {
  final String? id;
  const ProposalsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProposalsBloc, ProposalsState>(
        listener: ((context, state) {
      if (state is HireFreelancerLoading) {
        context.loaderOverlay.show();
      }
      if (state is HireFreelancerLoaded) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hiring Freelancer'),
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
                    const Text("Freelancer Successfully Hired"),
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
      
      } else if (state is ErrorLoadingHireFreelancer) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
        context.pop();
      } else if (state is ProposalsLoading) {
        context.loaderOverlay.show();
      } else if (state is ErrorLoadingProposals) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is ProposalsLoaded) {
        proposalJob = state.job;
        context.loaderOverlay.hide();
      }
    }), builder: ((context, state) {
      if (state is ProposalsInitial) {
        var _proposalsBloc = BlocProvider.of<ProposalsBloc>(context);
        _proposalsBloc.add(ViewProposalsEvent(id: id!));
      }
      if (state is ProposalsLoaded || state is HireFreelancerLoaded) {
        return Scaffold(
            appBar: AppBar(title: const Text('Proposals Page')),
            body: SingleChildScrollView(
              child: ProposalDisplay(job: proposalJob),
            ));
      } else {
        return Scaffold(
          appBar: AppBar(title: const Text('Proposals Page')),
          body: const Center(child: CircularProgressIndicator()),
        );
      }
    }));
  }
}
