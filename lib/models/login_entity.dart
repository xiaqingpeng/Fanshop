class LoginEntity {
late	UserModel  userModel;
late	MsgModel msgModel;
	LoginEntity({required this.userModel,required this.msgModel});
	LoginEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			if(json['data'].isNotEmpty){
				userModel =new UserModel.fromJson(json['data']);
			}else{
				msgModel=new MsgModel.fromJson(json);
			}
		}
	}
}
class UserModel {

late	String token;
	UserModel({ required this.token});

	UserModel.fromJson(Map<String, dynamic> json) {

		token = json['token'];
	}

}
class MsgModel{
late	String msg;
	MsgModel({required this.msg});
	MsgModel.fromJson(Map<String, dynamic> json){
		msg=json['msg'];
	}

}
