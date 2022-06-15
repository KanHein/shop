import 'package:shop/models/item.dart';

class VariationItem extends Item
{
  String? menuId;
  VariationItem.fromJson(String id, Map<String, dynamic> jsonData)
  {
    id = id;
    menuId = jsonData['menu_id'];
    name = jsonData['name'];
    price = jsonData['price'];
  }
}