import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../_core/di/get_It.dart';
import '../../../payments/views/bloc/transaction_bloc/transaction_bloc.dart';
import '../../../payments/views/widgets/widgets.dart';
import '../../../review/router.dart';
import '../../../user/views/profile/bloc/profile_bloc.dart';
import '../widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(create: (context) => container()),
        BlocProvider<ProfileBloc>(create: (context) => container()),
      ],
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 56,
        width: double.infinity,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                ResponsiveRowColumn(
                  layout: ResponsiveWrapper.of(context).isLargerThan(TABLET)
                      ? ResponsiveRowColumnType.ROW
                      : ResponsiveRowColumnType.COLUMN,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: StaggeredGrid.count(
                        crossAxisCount:
                            ResponsiveWrapper.of(context).isMobile ? 1 : 2,
                        children: [
                          DashboardCount(
                            label: "Completed Jobs",
                            count: state is ProfileLoaded
                                ? "${state.user.completedJobs}"
                                : "0",
                            viewMoreRoute: '',
                          ),
                          DashboardCount(
                            label: 'Cancelled Jobs',
                            count: state is ProfileLoaded
                                ? "${state.user.cancelledJobs}"
                                : "0",
                            viewMoreRoute: '',
                          ),
                          DashboardCount(
                            label: 'Ongoing Jobs',
                            count: state is ProfileLoaded
                                ? "${state.user.ongoingJobs}"
                                : "0",
                            viewMoreRoute: reviewRouteName,
                          ),
                        ],
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: DashboardStatic(
                        cancelledJobs: state is ProfileLoaded
                            ? state.user.cancelledJobs
                            : 0,
                        completedJobs: state is ProfileLoaded
                            ? state.user.completedJobs
                            : 0,
                        ongoingJobs:
                            state is ProfileLoaded ? state.user.ongoingJobs : 0,
                      ),
                    )
                  ],
                ),
                const Expanded(child: RecentTransactionTable()),
              ],
            );
          },
        ),
      ),
    );
  }
}
