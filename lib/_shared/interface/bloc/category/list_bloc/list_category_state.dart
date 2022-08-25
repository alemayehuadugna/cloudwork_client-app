part of 'list_category_bloc.dart'; 

abstract class ListCategoryState extends Equatable {
  const ListCategoryState();

  @override
  List<Object> get props => [];
}

class ListCategoryInitial extends ListCategoryState {}

class ListCategoryLoading extends ListCategoryState {}

class ListCategoryLoaded extends ListCategoryState {
  final List<Category> category;

  const ListCategoryLoaded({required this.category});
}


class ErrorLoadingListCategory extends ListCategoryState {
  final String message;

  const ErrorLoadingListCategory({required this.message});
}