import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String categoryName;
  final List<String> subcategories;

  const Category({required this.categoryName, required this.subcategories});

  @override
  List<Object?> get props => [categoryName, subcategories];
}
