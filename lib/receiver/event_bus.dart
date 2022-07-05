import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class UserLoggedInEvent {
  late String text;
  UserLoggedInEvent(String text){
    this.text = text;
  }
}
class UserNumInEvent{
  late String num;
  UserNumInEvent(String text){
    this.num=text;
  }
}
class GoodsNumInEvent{
 late String  event;
  GoodsNumInEvent(String text){
    this.event=text;
  }
}
class IndexInEvent{
  late String  index; 
  IndexInEvent(String text){
    this.index=text;
  }
}
class OrderInEvent {
 late String text;
  OrderInEvent(String text){
    this.text = text;
  }
}
class UserInfoInEvent {
 late String text;
  UserInfoInEvent(String text){
    this.text = text;
  }
}
class SpecEvent{
 late String  code;
  SpecEvent(String text){
    this.code=text;
  }
}
