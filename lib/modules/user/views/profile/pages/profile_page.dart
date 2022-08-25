import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/modules/user/views/profile/bloc/profile_bloc.dart';
import 'package:clean_flutter/modules/user/views/profile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: profileBody(context));
  }

  BlocProvider<ProfileBloc> profileBody(BuildContext context) {
    return BlocProvider(
      create: (context) => container<ProfileBloc>(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (((context, state) {
            if (state is ProfileInitial || state is ProfileLoading) {
              var _profileBloc = BlocProvider.of<ProfileBloc>(context);
              _profileBloc.add(GetProfileEvent());
            } else if (state is ProfileLoaded) {
              return ProfileDisplay(user: state.user);
            } else if (state is ErrorLoadingProfile) {
              return MessageDisplay(message: state.message);
            }
            return Container();
          }))),
        ),
      ),
    );
  }
}
