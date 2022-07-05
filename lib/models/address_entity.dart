class AddressEditEntity {
 late AddressModel  addressModel;

  AddressEditEntity({required this.addressModel});
  AddressEditEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      addressModel =AddressModel.fromJson(json['data']);
    }
  }
}
class AddressModel {
//  "addressDetail":"人民路12号",
//  "areaCode":"110101",
//  "city":"北京市",
//  "createTime":"",
//  "district":"东城区",
//  "id":"1",
//  "idUser":"1",
//  "isDefault":true,
//  "isDelete":false,
//  "modifyTime":"",
//  "name":"路飞",
//  "postCode":"",
//  "province":"北京市",
//  "tel":"15011113333"
  late String addressDetail;
  late String areaCode;
  late String city;
  late String district;
  late bool isDefault;
  late String name;
  late String province;
  late String tel;
  late String id;
  late String idUser;
  late bool isDelete;

  AddressModel({required this.addressDetail, required this.areaCode,required this.city,required this.district,required this.isDefault,
  required this.name,required this.province,required this.tel,required this.id,required this.idUser,required this.isDelete});
  AddressModel.fromJson(Map<String, dynamic> json) {
    addressDetail = json['addressDetail'].toString();
    areaCode = json['areaCode'].toString();
    city = json['city'].toString();
    district = json['district'].toString();
    isDefault = json['isDefault'];
    name = json['name'].toString();
    province = json['province'].toString();
    tel = json['tel'].toString();
    id = json['id'].toString();
    idUser = json['idUser'].toString();
    isDelete= json['isDelete'];
  }
}
