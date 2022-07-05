class OrderFormEntity {
  List<OrderFormListItem> items;

  OrderFormEntity(this.items);

}

enum OrderForm{
  payment,
  waitsending,
  aftersending,
  finished
}

abstract class OrderFormListItem {
  late int id;
  late String storeName;
  late String imgUrl;
  late String status;
  late String title;
  late double price;
  late int amount;
  late String weight;
  late double total;
  late OrderForm type;

}











