class Product {
  const Product({
    // ignore: non_constant_identifier_names
    required this.category_id,
    // ignore: non_constant_category_identifier_names, non_constant_identifier_names
    required this.category_name,
    // ignore: non_constant_identifier_names
    required this.current_price,
    // ignore: non_constant_category_identifier_names, non_constant_identifier_names
    required this.market_price,
    // ignore: non_constant_identifier_names
    required this.product_image,
    // ignore: non_constant_category_identifier_names, non_constant_identifier_names
    required this.product_name,
    // ignore: non_constant_identifier_names
    required this.product_id,
  });
  // ignore: non_constant_identifier_names
  final String category_id;
  // ignore: non_constant_category_identifier_names, non_constant_identifier_names
  final String category_name;
  // ignore: non_constant_identifier_names
  final int current_price;
  // ignore: non_constant_category_identifier_names, non_constant_identifier_names
  final int market_price;
  // ignore: non_constant_category_identifier_names, non_constant_identifier_names
  final String product_image;
  // ignore: non_constant_identifier_names
  final String product_name;
  // ignore: non_constant_category_identifier_names, non_constant_identifier_names
  final String product_id;
}

// product_name  current_price current_price  product_image  product_category_id category_name category_category_id
final List<Product> products = [
  const Product(
    category_id: "c100001",
    category_name: "数码家电",
    current_price:9999,
    market_price:12000,
    product_name:"小米智能摄像头电视",
    product_image:"https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1642667201568.jpg",
    product_id:"p100001",
  ),
  const Product(
    category_id: "c100001",
    category_name: "数码家电",
    current_price:499,
    market_price:699,
    product_name:"小度智能词典笔旗舰版",
    product_image:"https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1642667271700.jpg",
    product_id:"p100002",
  ),
  const Product(
    category_id: "c100001",
    category_name: "数码家电",
    current_price:4399,
    market_price:5999,
    product_name:"大疆无人机",
    product_image:"https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1642667201568.jpg",
    product_id:"p100003",
  ),
  const Product(
    category_id: "c100001",
    category_name: "数码家电",
    current_price:1499,
    market_price:1699,
    product_name:"华米手环",
    product_image:"https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1642667271700.jpg",
    product_id:"p100004",
  ),
  const Product(
    category_id: "c100001",
    category_name: "数码家电",
    current_price:2399,
    market_price:3999,
    product_name:"华为平板",
    product_image:"https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1642667201568.jpg",
    product_id:"p100005",
  ),
  const Product(
    category_id: "c100001",
    category_name: "数码家电",
    current_price:1099,
    market_price:1699,
    product_name:"创维液晶电视",
    product_image:"https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1642667271700.jpg",
    product_id:"p100006",
  ),
 
];
