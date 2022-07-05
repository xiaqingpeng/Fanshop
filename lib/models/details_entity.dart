import 'dart:math';

/**
 * 商品详情页面
 */
class DetailsEntity {
late	GoodsModelAndSku goods;
	DetailsEntity({required this.goods});
	DetailsEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			if(json['data']['sku'] !=null) {
				goods = GoodsModelAndSku.fromJson(
						json['data']['goods'], json['data']['sku']);
			}else{
				goods = GoodsModelAndSku.fromJson(
						json['data']['goods'], {});
			}
		}
	}
}
class GoodsModelAndSku{
	late GoodsModelDetail goodsModelDetail;
	late SkuModel skuModel;
	GoodsModelAndSku({required this.goodsModelDetail,required this.skuModel});
	GoodsModelAndSku.fromJson(Map<String, dynamic> jsonGoods,Map<String, dynamic> jsonSku){
		goodsModelDetail =new GoodsModelDetail.fromJson(jsonGoods);
		// ignore: unnecessary_null_comparison
		if(null==jsonSku){
			skuModel = {} as SkuModel;
		}else {
			skuModel = SkuModel.fromJson(jsonSku);
		}
	}

}
class SkuModel{
 late bool hide_stock;
 late bool none_sku;
 late int price;
late	List<TreeModel> treeModel;
late	List<listModel> listModels;
	SkuModel({required this.hide_stock,required this.none_sku,required this.price,required this.treeModel,required this.listModels});
	SkuModel.fromJson(Map<String, dynamic> json){
		hide_stock=json['hide_stock'];
		none_sku=json['none_sku'];
		if(json['price'].toString().isEmpty){
			price=0;
		}else {
			price = int.parse(json['price'].toString());
		}
		List<Map> dataListTree= (json['tree'] as List).cast();
		treeModel = <TreeModel>[];
		listModels = <listModel>[];

		dataListTree.forEach((t) {
			treeModel.add(TreeModel.fromJson(t as Map<String,dynamic>));
		});
		if(null!=json['list']) {
			List<Map> dataListTreeList = (json['list'] as List).cast();
			dataListTreeList.forEach((l) {
				listModels.add(listModel.fromJson(l as Map<String,dynamic>, treeModel));
			});
		}
	}
}
class TreeModel{
late	String k_s;
late	String k;
late	List<vModel> vModels;

	TreeModel({required this.k,required this.k_s,required this.vModels});
	TreeModel.fromJson(Map<String, dynamic> json){
		k_s=json['k_s'];
		k= json['k'];
		List<Map> dataList= (json['v'] as List).cast();
		vModels=<vModel>[];
		dataList.forEach((v) {
			vModels.add(vModel.fromJson(v as Map<String,dynamic>));


		});
	}

}
class vModel{
late	String id;
late	String name;
	vModel({required this.id,required this.name});
	vModel.fromJson(Map<String, dynamic> json){
		id = json['id'];

		name=json['name'];
	}
}
class listModel{
//	"price": 69900,
//	"id": "1",
//	"s1": "1",
//	"s2": "3",
//	"stock_num": 100
//	"code": "1,3",
late int price;
late   String id;
 late  int stock_num;
 late  String code;
 late  Map<String,String> map;
	 listModel({required this.price,required this.id,required this.stock_num,required this.map,required this.code});
	 listModel.fromJson(Map<String, dynamic> json,List<TreeModel> trModel){
		 id = json['id'];
		 if(json['price'].toString().isEmpty){
		 	price = 0;
		 }else {
			 price = int.parse(json['price'].toString());
		 }
		 if(json['stock_num'].toString().isEmpty){
			 stock_num = 0;
		 }else {
			 stock_num = int.parse(json['stock_num'].toString());
		 }
		 code = json['code'];

		 map=Map<String,String>();
		 trModel.forEach((e){
			 map[e.k_s] = json[e.k_s];
		 });

	 }

}



class GoodsModelDetail {
late	String createBy;
late	String createTime;
late	String descript;
late	String gallery;
late	String detail;
late	String idCategory;
late	String id;
late	bool isDelete;
late	bool isOnSale;
late	String modifyBy;
late	String modifyTime;
late	String name;
late	int  num;
late	String pic;
late	 int price;
late	String specifications;


	GoodsModelDetail({required this.createBy, required this.createTime, required this.descript, required this.detail,
		required this.idCategory,required this.isDelete,required this.isOnSale,required this.modifyBy,required this.modifyTime,
		required this.name,required this.num,required this.pic,required this.price,required this.specifications,required this.id,required this.gallery});

	GoodsModelDetail.fromJson(Map<String, dynamic> json) {
		createBy = json['createBy'];
		createTime = json['createTime'];
		descript = json['descript'];
		detail = json['detail'];
		idCategory = json['idCategory'];
		isDelete = json['isDelete'];
		isOnSale=json['isOnSale'];
		modifyBy=json['modifyBy'];
		modifyTime=json['modifyTime'];
		name = json['name'];
		if(json['stock'].toString().isEmpty){
			num =0;
		}else{
			num = int.parse(json['stock'].toString());
		}

		pic = json['pic'];
		if(json['price'].toString().isEmpty){
			price =0;
		}else{
			price = int.parse(json['price'].toString());
		}

		specifications = json['specifications'];
		id=json['id'];
		gallery=json['gallery'];
	}


}
