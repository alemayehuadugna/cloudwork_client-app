import 'package:bloc/bloc.dart';

class DesktopSideNavCubit extends Cubit<bool> {
  DesktopSideNavCubit() : super(true);

  changeSideNavState() {
    emit(!state);
  }
}
