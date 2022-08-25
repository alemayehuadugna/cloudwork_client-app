import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di/get_It.dart';
import '../bloc/freelancer_detail_bloc.dart';
import '../widgets/widgets.dart';

class FreelancerDetailPage extends StatelessWidget {
  const FreelancerDetailPage({Key? key, required this.id}) : super(key: key);

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Freelancer Detail",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(child: buildBody()),
    );
  }

  BlocProvider<FreelancerDetailBloc> buildBody() {
    return BlocProvider(
      create: (context) => container<FreelancerDetailBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<FreelancerDetailBloc, FreelancerDetailState>(
                builder: ((context, state) {
                  if (state is FreelancerDetailInitial ||
                      state is FreelancerDetailLoading) {
                    var _profileBloc =
                        BlocProvider.of<FreelancerDetailBloc>(context);
                    _profileBloc.add(GetFreelancerDetailEvent(id!));
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is FreelancerDetailLoaded) {
                    // print("state.freelancer: ${state.freelancer}");
                    // return Container();
                    return ProfileDisplay(user: state.freelancer);
                  } else if (state is FreelancerDetailError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: const Center(
                        child: SingleChildScrollView(
                          child: Text(
                            "message",
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }

                  return Container();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
