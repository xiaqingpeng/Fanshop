class TopicGoodsQueryEntity {
  late List<TopicGoodsListModel> topicGoods;
  TopicGoodsQueryEntity({required this.topicGoods});
  TopicGoodsQueryEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      topicGoods = <TopicGoodsListModel>[];
//			print(goods.runtimeType);
      (json['data'] as List).forEach((v) {
        topicGoods.add(new TopicGoodsListModel.fromJson(v));
//				print(goods.length);
      });
    }
  }
}

class TopicGoodsListModel {
 late TopicGoodsModel topicGoodsModel;

//	"createBy": "1",
//	"createTime": "2020-01-08 21:25:53",
//	"disabled": false,
//	"goodsList": [],
//	"id": "1",
//	"idArticle": "1",
//	"idGoodsList": "1,5,10,12",
//	"modifyBy": "1",
//	"modifyTime": "2020-01-08 21:25:53",
//	"pv": "10000",
//	"title": "智能新品好物"
  late String createBy;
  late String createTime;
  late bool disabled;
  late String id;
 late  String idArticle;
 late  String idGoodsList;
 late  String modifyBy;
 late  String modifyTime;
 late  String pv;
 late  String title;

  TopicGoodsListModel(
      {required this.createBy,
      required this.createTime,
      required this.disabled,
      required this.id,
      required this.idArticle,
      required this.idGoodsList,
      required this.modifyBy,
      required this.modifyTime,
      required this.pv,
      required this.title,
      required this.topicGoodsModel});

  TopicGoodsListModel.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'].toString();
    createTime = json['createTime'];
    disabled = json['disabled'];
    id = json['id'].toString();
    idArticle = json['idArticle'].toString();
    idGoodsList = json['idGoodsList'];
    modifyBy = json['modifyBy'].toString();
    modifyTime = json['modifyTime'];
    pv = json['pv'].toString();
    title = json['title'];

    if (json['article'] != null) {
      topicGoodsModel = new TopicGoodsModel.fromJson(json['article']);
    }
  }
}

class TopicGoodsModel {
 late String author;
 late String content;
 late String createBy;
 late String id;
 late String idChannel;
 late String img;
 late String createTime;
 late String modifyBy;
late  String modifyTime;
late  String title;

  TopicGoodsModel(
      {required this.author,
      required this.content,
      required this.createTime,
      required this.id,
      required this.idChannel,
      required this.img,
     required  this.modifyBy,
     required  this.modifyTime,
     required  this.title});

  TopicGoodsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    createBy = json['createBy'].toString();
    id = json['id'].toString();
    idChannel = json['idChannel'].toString();
    img = json['img'];
    createTime = json['createTime'];
    modifyBy = json['modifyBy'].toString();
    modifyTime = json['modifyTime'];
    title = json['title'];
  }
}
