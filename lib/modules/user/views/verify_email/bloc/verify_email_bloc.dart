import 'package:bloc/bloc.dart';
import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/_shared/interface/bloc/auth/auth_bloc.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:clean_flutter/modules/user/domain/usecase/email/resend_otp.dart';
import 'package:clean_flutter/modules/user/domain/usecase/email/verify_email.dart';
import 'package:clean_flutter/modules/user/domain/usecase/email/verify_forget_email.dart';
import 'package:clean_flutter/modules/user/domain/usecase/get_basic_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final AuthBloc _authBloc;
  final GetBasicUserUsecase _getBasicUserUsecase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendOTPUseCase _resendOTPUseCase;
  final VerifyForgetEmailUsecase _verifyForgetEmailUsecase;

  VerifyEmailBloc(
      {required AuthBloc authBloc,
      required GetBasicUserUsecase getBasicUserUsecase,
      required VerifyEmailUseCase verifyEmailUseCase,
      required ResendOTPUseCase resendOTPUseCase,
      required VerifyForgetEmailUsecase verifyForgetEmailUsecase})
      : _authBloc = authBloc,
        _getBasicUserUsecase = getBasicUserUsecase,
        _verifyEmailUseCase = verifyEmailUseCase,
        _resendOTPUseCase = resendOTPUseCase,
        _verifyForgetEmailUsecase = verifyForgetEmailUsecase,
        super(VerifyEmailInitial()) {
    on<VerifyEmailRequested>(_verifyRequested);
    on<ResendOTPRequested>(_resendOTPRequested);
    on<VerifyForgetEmailEvent>(_verifyForgetEmailEvent);
  }

  Future<void> _verifyRequested(
    VerifyEmailRequested event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(VerifyEmailLoading());

    try {
      final result = await _verifyEmailUseCase(
        VerifyEmailParams(event.code, event.email),
      );

      emit(await result.fold((error) {
        if (error is ServerFailure) {
          return VerifyEmailFailure(error: error.message);
        }
        return const VerifyEmailFailure(error: "Verification Failed");
      }, (_) async {
        await Future<Either<Failure, BasicUser>>(
            () => _getBasicUserUsecase(NoParams())).then((value) {
          return {
            emit(value.fold(
              (error) => const VerifyEmailFailure(
                error: 'Error Getting your data',
              ),
              (user) {
                _authBloc.add(UserLoggedIn(user: user));
                return VerifyEmailSuccess();
              },
            ))
          };
        });
        return VerifyEmailSuccess();
      }));
    } catch (e) {
      emit(const VerifyEmailFailure(error: 'Error has Occurred'));
    }
  }

  Future<void> _verifyForgetEmailEvent(
    VerifyForgetEmailEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(VerifyEmailLoading());

    try {
      final result = await _verifyForgetEmailUsecase(
          VerifyForgetEmailParams(event.code, event.email));

      emit(await result.fold(
        (error) {
          if (error is ServerFailure) {
            return VerifyEmailFailure(error: error.message);
          }
          return const VerifyEmailFailure(error: "Verification Failed");
        },
        (_) => VerifyForgetEmailSuccess(),
      ));
    } catch (e) {
      emit(const ResendOTPFailure(error: 'Error Resending OTP'));
    }
  }

  Future<void> _resendOTPRequested(
    ResendOTPRequested event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(ResendOTPLoading());

    try {
      final result = await _resendOTPUseCase(
        ResendOTPParams(event.email, event.type),
      );

      emit(await result.fold(
        (error) {
          if (error is ServerFailure) {
            return ResendOTPFailure(error: error.message);
          }

          return const ResendOTPFailure(error: 'Resending OTP Failed');
        },
        (_) => ResendOTPSuccess(),
      ));
    } catch (e) {
      emit(const ResendOTPFailure(error: 'Error Resending OTP'));
    }
  }
}
