import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/usecase/list_categories.dart';

part 'list_category_event.dart';
part 'list_category_state.dart';

class ListCategoryBloc extends Bloc<ListCategoryEvent, ListCategoryState> {
  final ListCategory _listCategory;

  ListCategoryBloc({
    required ListCategory listCategory,
  })  : _listCategory = listCategory,
        super(ListCategoryInitial()) {
    on<ListCategoryInSubmitted>(_listCategoryInSubmitted);
  }

  Future<void> _listCategoryInSubmitted(
      ListCategoryInSubmitted event, Emitter<ListCategoryState> emit) async {
    emit(ListCategoryLoading());
    final result = await _listCategory(NoParams());
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingListCategory(message: error.message);
        }
        return const ErrorLoadingListCategory(message: 'Unknown Error');
      }, (category) => ListCategoryLoaded(category: category)),
    );
  }
}
