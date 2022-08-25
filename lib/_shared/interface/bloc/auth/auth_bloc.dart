import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/usecase.dart';
import '../../../../modules/alerts/domain/usecases/start_service.dart';
import '../../../../modules/chat/domain/usecases/start_chat.dart';
import '../../../../modules/chat/domain/usecases/stop_socket_service.dart';
import '../../../../modules/user/domain/entities/basic_user.dart';
import '../../../../modules/user/domain/usecase/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthStatusUseCase _authStatus;
  final GetBasicUserUsecase _getUser;
  // final SignInUseCase _signIn;
  final SignOutUseCase _signOut;
  final StartChatUseCase _startChat;
  final StopSocketService _stopSocketService;
  final StartAlertService _alertService;
  AuthBloc({
    required GetAuthStatusUseCase authStatus,
    required GetBasicUserUsecase getUser,
    // required SignInUseCase signIn,
    required SignOutUseCase signOut,
    required StartChatUseCase startChatUseCase,
    required StopSocketService stopSocketService,
    required StartAlertService startAlertService,
  })  : _authStatus = authStatus,
        _getUser = getUser,
        // _signIn = signIn,
        _signOut = signOut,
        _startChat = startChatUseCase,
        _stopSocketService = stopSocketService,
        _alertService = startAlertService,
        super(AuthInitial()) {
    on<AppLoaded>(_appLoaded);
    on<UserLoggedIn>(_userLoggedIn);
    on<UserLoggedOut>(_userLoggedOut);
  }
  Future<void> _appLoaded(AppLoaded event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authStatus(NoParams());
      var isAuth = result.fold((l) => false, (isAuth) => isAuth);
      if (isAuth) {
        var result = await _getUser(NoParams());
        var user = result.fold((l) => null, (user) => user);
        if (user != null && user.isEmailVerified) {
          _startChat(StartChatParams(user.id));
          _alertService(user.id);
          emit(Authenticated(user: user));
        } else if (user != null && !user.isEmailVerified) {
          emit(Unverified(user: user));
        } else {
          emit(const AuthFailure(message: 'Error Getting User Data'));
        }
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(const AuthFailure(message: 'error occurred'));
    }
  }

  void _userLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) {
    emit(AuthLoading());
    if (event.user.isEmailVerified) {
      _startChat(StartChatParams(event.user.id));
      _alertService(event.user.id);
      emit(Authenticated(user: event.user));
    } else if (!event.user.isEmailVerified) {
      emit(Unverified(user: event.user));
    }
  }

  void _userLoggedOut(UserLoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _stopSocketService(NoParams());
    await _signOut(NoParams());
    emit(Unauthenticated());
  }
}
