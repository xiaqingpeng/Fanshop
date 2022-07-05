class MsgEntity {
 late MsgModel  msgModel;
  MsgEntity({required this.msgModel});
  MsgEntity.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      msgModel =new MsgModel.fromJson(json);
    }
  }
}
class MsgModel {
 late String msg;
 late String data;
 late int code;
  MsgModel({required this.msg, required this.code,required this.data});
  MsgModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'];
  }

}