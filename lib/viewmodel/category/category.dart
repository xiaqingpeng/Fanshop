class Category {
  const Category({
    // ignore: non_constant_identifier_names
    required this.category_id,
    // ignore: non_constant_category_identifier_names
    required this.category_name,
  });
  // ignore: non_constant_identifier_names
  final String category_id;
  // ignore: non_constant_category_identifier_names, non_constant_identifier_names
  final String category_name;
}

final List<Category> categorys = [
  const Category(
    category_id: "c100001",
    category_name: '数码家电',
  ),
  const Category(
    category_id: "c100002",
    category_name: '手机通讯',
  ),
  const Category(
    category_id: "c100003",
    category_name: '美妆护肤',
  ),
  const Category(
    category_id: "c100004",
    category_name: '家具百货',
  ),
  const Category(
    category_id: "c100005",
    category_name: '食品酒饮',
  ),
  const Category(
    category_id: "c100006",
    category_name: '医药健康',
  ),
  const Category(
    category_id: "c100007",
    category_name: '服装饰品',
  ),
  const Category(
    category_id: "c100008",
    category_name: '生鲜花束',
  ),
  const Category(
    category_id: "c100009",
    category_name: '文教办公',
  ),
  const Category(
    category_id: "c1000010",
    category_name: '汽摩配套',
  ),
];
