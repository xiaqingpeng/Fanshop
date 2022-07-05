
/**
 * 推荐详情页面
 */
class TopicDetailsEntity {
late	ArticleModel articleModel;
late	List<TopGoods>   goodsList;
	TopicDetailsEntity({required this.articleModel,required this.goodsList});
	TopicDetailsEntity.fromJson(Map<String, dynamic> json) {
		goodsList = <TopGoods> [];
		if(json['data']['article'] !=null) {
			articleModel = ArticleModel.fromJson(json['data']['article']);
		}
		List<Map> dataList= (json['data'] ['goodsList'] as List).cast();
		dataList.forEach((v){
			goodsList.add(new TopGoods.fromJson(v as Map<String,dynamic>));
		});
	}

}
class ArticleModel{
late	String title;
late	String content;
	ArticleModel.fromJson(Map<String, dynamic> json){
		title=json['title'];
		content=json['content'];
	}

}
class TopGoods {
late	String name;
late	String pic;
late	String id;
	TopGoods.fromJson(Map<String, dynamic> json){
		name = json['name'];
		pic = json['pic'];
		id = json['id'].toString();
	}
}

