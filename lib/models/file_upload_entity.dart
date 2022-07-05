class FileEntity {
  late FileModel  msgModel;
  FileEntity({required this.msgModel});
  FileEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      msgModel =FileModel.fromJson(json['data'],json['msg']);
    }
  }
}
class FileModel {
 late  String avatar;
 late String nickName;
 late String msg;

  FileModel({required this.avatar, required this.nickName,required this.msg});
  FileModel.fromJson(Map<String, dynamic> json,String message) {
    avatar = json['avatar'];
    nickName = json['nickName'];
    msg=message;
  }

}