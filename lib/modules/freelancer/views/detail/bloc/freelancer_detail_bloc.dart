import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../domain/entities/freelancer_detail.dart';
import '../../../domain/usecases/get_freelancer_detail.dart';

part 'freelancer_detail_event.dart';
part 'freelancer_detail_state.dart';

class FreelancerDetailBloc
    extends Bloc<FreelancerDetailEvent, FreelancerDetailState> {
  final GetFreelancerDetailUseCase getFreelancerDetailUseCase;
  FreelancerDetailBloc({required this.getFreelancerDetailUseCase})
      : super(FreelancerDetailInitial()) {
    on<GetFreelancerDetailEvent>(_getFreelancerDetail);
  }

  void _getFreelancerDetail(
    GetFreelancerDetailEvent event,
    Emitter<FreelancerDetailState> emit,
  ) async {
    emit(FreelancerDetailLoading());

    final result = await getFreelancerDetailUseCase(event.id);
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return FreelancerDetailError(error.message);
        }
        return const FreelancerDetailError('Error Occurred Getting Reviews');
      },
      (freelancer) => FreelancerDetailLoaded(freelancer),
    ));
  }
}
