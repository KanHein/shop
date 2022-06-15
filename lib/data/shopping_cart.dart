import '../models/item.dart';

class ShoppingCart
{
  static List<Item> items = [];

  static void addToCart(Item item)
  {
    if(items.contains(item)) {
      items.remove(item);
    }else{
      items.add(item);
    }

  }

  static bool checkItem(Item item)
  {
    if(items.contains(item))
    {
      return true;
    }else{
      return false;
    }
  }

  static void clearCart()
  {
    items = [];
  }
}