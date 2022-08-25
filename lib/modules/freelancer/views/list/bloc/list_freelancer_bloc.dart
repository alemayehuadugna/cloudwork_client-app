import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/cqrs.dart';
import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../../domain/entities/freelancer_basic.dart';
import '../../../domain/usecases/list_freelancer.dart';

part 'list_freelancer_event.dart';
part 'list_freelancer_state.dart';

class ListFreelancerBloc
    extends Bloc<ListFreelancerEvent, ListFreelancerState> {
  final ListFreelancersUseCase listFreelancers;
  ListFreelancerBloc({required this.listFreelancers})
      : super(ListFreelancerInitial()) {
    on<LoadFreelancersEvent>(_loadFreelancersEvent);
  }

  void _loadFreelancersEvent(
    LoadFreelancersEvent event,
    Emitter<ListFreelancerState> emit,
  ) async {
    emit(ListFreelancerLoading());
    var result = await listFreelancers(
        QueryParams(event.pagination, event.filter, event.sort));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ListFreelancerError(error.message);
        }
        return const ListFreelancerError('Error Loading Transactions');
      },
      (d) {
        return ListFreelancerLoaded(d.data ?? [], d.page);
      },
    ));
  }
}
