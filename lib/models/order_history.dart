import 'order.dart';

class OrderHistory
{
  List<Order>? orders;
  String? date;
  OrderHistory(this.orders, this.date);
  OrderHistory.fromJson(Map<String, dynamic> jsonData)
  {
    date = jsonData['date'];
    orders = [];
    for(var item in jsonData['order_items']){
      orders?.add(Order.fromJson(item));
    }
  }
}