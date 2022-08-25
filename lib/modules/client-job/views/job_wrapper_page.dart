import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../_core/di/get_It.dart';
import '../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../_shared/interface/bloc/category/list_bloc/list_category_bloc.dart';
import '../common/constant.dart';
import 'job_detail/blocs/get_job_bloc.dart';
import 'job_edit/bloc/edit_job_bloc.dart';
import 'job_list/bloc/list_job_bloc.dart';
import 'job_post/blocs/post_job_bloc.dart';
import 'job_proposal/bloc/proposal_bloc.dart';

class JobWrapperPage extends StatelessWidget {
  const JobWrapperPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Authenticated) {
        clientId = state.user.id;
        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ListJobBloc>(
                  create: (context) => container<ListJobBloc>()),
              BlocProvider<JobDetailBloc>(
                  create: (context) => container<JobDetailBloc>()),
              BlocProvider<JobEditBloc>(
                  create: (context) => container<JobEditBloc>()),
              BlocProvider<ProposalsBloc>(
                  create: (context) => container<ProposalsBloc>()),
              BlocProvider<JobPostBloc>(
                  create: (context) => container<JobPostBloc>()),
              BlocProvider<ListCategoryBloc>(
                  create: (context) => container<ListCategoryBloc>()),
            ],
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: Center(
                child: SpinKitCircle(
                  color: Theme.of(context).colorScheme.primary,
                  size: 50.0,
                ),
              ),
              overlayColor: Colors.black,
              overlayOpacity: 0.01,
              child: child,
            ),
          ),
        );
      } else {
        return const Align(alignment: Alignment.topCenter, child: Text(""));
      }
    }));
  }
}
