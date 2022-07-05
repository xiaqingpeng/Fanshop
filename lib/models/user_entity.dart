class UserEntity {
	late UserInfoModel  userInfoModel;
	late MsgModel msgModel;
	UserEntity({required this.userInfoModel,required this.msgModel});
	UserEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			if(json['data'].isNotEmpty){
				userInfoModel =new UserInfoModel.fromJson(json['data']);
			}else{
				msgModel=new MsgModel.fromJson(json);
			}
		}
	}
}
class UserInfoModel {
	late String avatar;
	late String mobile;
	late String nickName;
	late String id;
	late String gender;
	late Map<String, dynamic> jsonMap;


	UserInfoModel({required this.avatar, required this.mobile, required this.nickName,required this.gender});

	UserInfoModel.fromJson(Map<String, dynamic> json) {
		avatar = json['avatar'];
		mobile = json['mobile'];
		nickName = json['nickName'];
		id = json ['id'];
		gender = json ['gender'];
		jsonMap = json;
	}

}
class MsgModel{
	late String msg;
	MsgModel({required this.msg});
	MsgModel.fromJson(Map<String, dynamic> json){
		msg=json['msg'];
	}

}
