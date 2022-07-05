class MsgLikeEntity {
 late MsgLikeModel  msgModel;
  MsgLikeEntity({required this.msgModel});
  MsgLikeEntity.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      msgModel =new MsgLikeModel.fromJson(json);
    }
  }
}
class MsgLikeModel {
  late String msg;
 late bool data;
  late int code;
  MsgLikeModel({required this.msg, required this.code,required this.data});
  MsgLikeModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'];
  }

}