class CategoryModel{
  final int id;
  final String title;
  final int categoryParent;
  final List<String> property;
  final List<String> unitProperty;


  CategoryModel({required this.id,required this.title, required this.categoryParent, required this.property, required this.unitProperty});
}