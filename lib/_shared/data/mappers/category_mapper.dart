import '../../domain/entities/category.dart';
import '../models/json/category_remote_model.dart';

class CategoryMapper {
  static CategoryRemoteModel toModel(Category category) {
    CategoryRemoteModel categoryRemoteModel = CategoryRemoteModel(
        categoryName: category.categoryName,
        subCategory: category.subcategories);

    return categoryRemoteModel;
  }

  static List<Category> toEntity(List<CategoryRemoteModel> categoryModel) {
    List<Category> category = [];
    Category single;
    for (int i = 0; i < categoryModel.length; i++) {
      single = Category(
        categoryName: categoryModel[i].categoryName,
        subcategories: categoryModel[i].subCategory,
      );

      category.add(single);
    }
    return category;
  }

  static CategoryRemoteModel fromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var category;
    try {
      category = CategoryRemoteModel.fromJson(json);
    } catch (e) {
      print("in category mapper -->");
      print(e);
    }

    final CategoryRemoteModel categoryRemoteModel = CategoryRemoteModel(
      categoryName: category.categoryName,
      subCategory: category.subCategory,
    );
    return categoryRemoteModel;
  }
}
