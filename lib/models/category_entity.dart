class CategoryEntity {
	List<CategoryModel> category=[];
	CategoryEntity({required this.category});
	CategoryEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			// ignore: deprecated_member_use
			category = <CategoryModel>[];(json['data'] as List).forEach((v) {
				category.add(new CategoryModel.fromJson(v)); });
		}
	}
}
class CategoryModel{

	String name;
	String id;
	List<CategoryInfoModel> categoryInfoModels;
	CategoryModel({required this.name,required this.id,required this.categoryInfoModels});
	factory CategoryModel.fromJson(Map<String, dynamic> parsedJson){
		var list = parsedJson['bannerList'] as List;

		List<CategoryInfoModel> categoryInfoList =
		list.map((i) => CategoryInfoModel.fromJson(i)).toList();
		return CategoryModel(
				id: parsedJson['id'].toString(),
				name: parsedJson['name'],
				categoryInfoModels:categoryInfoList
		);
	}
}

class CategoryInfoModel {
  late String createBy;
  late String createTime;
  late String idFile;
  late String modifyBy;
  late String modifyTime;
  late String title;
  late String type;
  late String url;
  late String id;
  late String page;
  late String param;

  CategoryInfoModel(
      {required this.createBy,
      required this.createTime,
      required this.idFile,
      required this.modifyBy,
      required this.modifyTime,
      required this.title,
      required this.type,
      required this.url,
      required this.id,
      required this.page});

  CategoryInfoModel.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'].toString();
    createTime = json['createTime'];
    idFile = json['idFile'];
    modifyBy = json['modifyBy'].toString();
    modifyTime = json['modifyTime'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    id = json['id'].toString();
    page = json['page'];
    param = json['param'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createBy'] = this.createBy.toString();
    data['createTime'] = this.createTime;
    data['idFile'] = this.idFile;
    data['modifyBy'] = this.modifyBy.toString();
    data['modifyTime'] = this.modifyTime;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['id'] = this.id.toString();
    data['page'] = this.page;
    return data;
  }
}
