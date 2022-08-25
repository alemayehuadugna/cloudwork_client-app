import 'package:bloc/bloc.dart';

enum ThemeModeState { light, dark, system }

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeState.system);

  darkMode() {
    emit(ThemeModeState.dark);
  }

  lightMode() {
    emit(ThemeModeState.dark);
  }

  systemMode() {
    emit(ThemeModeState.system);
  }
}
