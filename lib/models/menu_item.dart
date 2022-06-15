import 'package:shop/models/item.dart';
import 'package:shop/models/variation_item.dart';

class MenuItem extends Item
{
  List<VariationItem>? variationItems;
  MenuItem.fromJson(String id, Map<String, dynamic> jsonData, List<VariationItem> vItems)
  {
    id = id;
    name = jsonData['name'];
    price = jsonData['price'];
    variationItems = vItems;
  }
}