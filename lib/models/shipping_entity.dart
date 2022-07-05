class ShippingAddresEntry {
 late List<ShippingAddressModel> shippingAddressModels;
  ShippingAddresEntry({required this.shippingAddressModels});

  ShippingAddresEntry.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      shippingAddressModels = <ShippingAddressModel>[];
      (json['data'] as List).forEach((v) {
        shippingAddressModels.add(new ShippingAddressModel.fromJson(v));
      });

    }
  }
}
class ShippingAddressModel {
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
late  String addressDetail;
 late String areaCode;
late  String city;
 late String district;
 late String name;
late  String province;
 late String tel;
 late String id;
 late bool isDefault;

  ShippingAddressModel({required this.addressDetail, required this.areaCode,required this.city,required this.district,
    required this.name,required this.province,required this.tel,required this.id,required this.isDefault});
  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    addressDetail = json['addressDetail'];
    areaCode = json['areaCode'];
    district = json['district'];
    name = json['name'];
    province =json['province'];
    tel =json['tel'];
    id =json['id'];
    city=json['city'];
    isDefault =json['isDefault'];
  }

}