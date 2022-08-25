import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/settings/widgets/password/password_change_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => container<SettingBloc>(),
        child: PasswordChangeForm());
  }
}
