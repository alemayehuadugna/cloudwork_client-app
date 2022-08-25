import 'package:bloc/bloc.dart';
import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/modules/user/domain/usecase/register.dart';
import 'package:clean_flutter/modules/user/views/sign_in/bloc/login_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LoginBloc _loginBloc;
  final RegisterUseCase _registerUseCase;

  RegisterBloc(
      {required LoginBloc loginBloc, required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        _loginBloc = loginBloc,
        super(RegisterInitial()) {
    on<RegistrationRequested>(_registrationRequested);
  }

  void _registrationRequested(
    RegistrationRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      final register = await _registerUseCase(
        RegisterParams(
            firstName: event.firstName,
            lastName: event.lastName,
            phone: event.phone,
            email: event.email,
            password: event.password),
      );
      emit(
        await register.fold(
          (error) {
            if (error is ServerFailure) {
              return RegisterFailure(error: error.message);
            }
            return const RegisterFailure(error: 'An unknown error occurred');
          },
          (uid) async {
            _loginBloc.add(LoginInSubmitted(
              email: event.email,
              password: event.password,
            ));
            return RegisterSuccess();
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
