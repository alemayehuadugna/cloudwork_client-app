import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class UseremailCubit extends Cubit<String> {
  UseremailCubit() : super("");

  setEmail(String email) {
    emit(email);
  }
}
