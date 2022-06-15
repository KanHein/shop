import 'item.dart';

class Order extends Item
{
  Order.fromJson(Map<String, dynamic> jsonData)
  {
    id = jsonData['item_id'];
    name = jsonData['name'];
    price = jsonData['price'];
    quantity = jsonData['quantity'];
  }
}