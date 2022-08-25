import 'package:bloc/bloc.dart';

class FilterFreelancerMenuCubit extends Cubit<bool> {
  FilterFreelancerMenuCubit() : super(false);

  void change() {
    emit(!state);
  }

  void showMenu() {
    emit(true);
  }

  void hideMenu() {
    emit(false);
  }
}
