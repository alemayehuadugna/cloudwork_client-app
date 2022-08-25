import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../domain/entities/basic_user.dart';
import '../../../domain/usecase/index.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final SignInUseCase _signIn;
  final GetBasicUserUsecase _getUser;
  LoginBloc({
    required AuthBloc authBloc,
    required SignInUseCase signIn,
    required GetBasicUserUsecase getUser,
  })  : _authBloc = authBloc,
        _signIn = signIn,
        _getUser = getUser,
        super(LoginInitial()) {
    on<LoginInSubmitted>(_loginInSubmitted);
  }

  Future<void> _loginInSubmitted(
      LoginInSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final result = await _signIn(Params(
        email: event.email,
        password: event.password,
      ));
      emit(
        await result.fold(
          (l) => LoginFailure(error: "Error Logging In try again...."),
          (token) async {
            await Future<Either<Failure, BasicUser>>(() => _getUser(NoParams()))
                .then(
              (value) {
                return {
                  emit(value.fold(
                      (l) => LoginFailure(error: 'Error Getting your data'),
                      (user) {
                    _authBloc.add(UserLoggedIn(user: user));
                    return LoginSuccess();
                  }))
                };
              },
            );
            return LoginSuccess();
          },
        ),
      );
    } catch (e) {
      emit(LoginFailure(error: 'An unknown error occurred'));
    }
  }
}
