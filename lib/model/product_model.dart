
class Product {
  // ignore: non_constant_identifier_names
  late final int category_id;
  // ignore: non_constant_identifier_names
  late final String product_image;
  // ignore: non_constant_identifier_names
  late final int current_price;
  // ignore: non_constant_identifier_names
  late final int market_price;
  // ignore: non_constant_identifier_names
  late final String product_name;
  // ignore: non_constant_identifier_names
  late final int product_id;

  Product({
    // ignore: non_constant_identifier_names
    required this.category_id,
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
    // ignore: non_constant_identifier_names
  });
  static List<Product> fromJson(Map json) {
    List<Product> _product = [];
    var mapData = json['data'];
    mapData.forEach(
          (obj) {
        Product products = Product(
          category_id: obj['id'],
          current_price: obj['current_price'],
          market_price: obj['market_price'],
          product_image: obj['product_image'],
          product_name: obj['product_name'],
          product_id: obj['id'],
        );
        _product.add(products);
      },
    );
    return _product;
  }
}