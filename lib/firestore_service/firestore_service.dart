import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/menu_item.dart';
import 'package:shop/models/variation_item.dart';

import '../models/item.dart';
import '../models/order_history.dart';
class FirestoreService
{
  final CollectionReference _menuCollection = FirebaseFirestore.instance.collection('menu_item');
  final CollectionReference _variationCollection = FirebaseFirestore.instance.collection("variation_item");
  final CollectionReference _orderCollection = FirebaseFirestore.instance.collection("order");

  Future<List<MenuItem>> menuItems() async{
    List<MenuItem> menuItems = [];
    final QuerySnapshot menuItemData = await _menuCollection.get();
    final List<QueryDocumentSnapshot> menuItemDocs = menuItemData.docs;
    for (var menuItem in menuItemDocs) {
      List<VariationItem> variationItems = [];
      final variationItemData = await _variationCollection.where("menu_id", isEqualTo: menuItem.id).get();
      final List<QueryDocumentSnapshot> variationItemsDocs = variationItemData.docs;
      for(var variationItem in variationItemsDocs)
      {
        variationItems.add(VariationItem.fromJson(variationItem.id, variationItem.data() as Map<String, dynamic>));
      }

      menuItems.add(MenuItem.fromJson(menuItem.id, menuItem.data() as Map<String, dynamic>, variationItems));
    }
    return menuItems;
  }

  Future<bool> submitOrder(List<Item> items) async{
    var date = DateTime.now().toString().split(".")[0];
    List<Map<String, dynamic>> orderItems = [];
    for(var item in items){
      orderItems.add({
        "item_id": item.id,
        "name": item.name,
        "price": item.price,
        "quantity": item.quantity
      });
    }
    await _orderCollection.add({
      "date": date,
      "order_items": orderItems,
    });
    return true;
  }

  Future<List<OrderHistory> >orderHistories() async{
    List<OrderHistory> histories = [];
    final QuerySnapshot orders = await _orderCollection.get();
    final List<QueryDocumentSnapshot> orderDocs = orders.docs;

    for(var order in orderDocs)
    {
      histories.add(OrderHistory.fromJson(order.data() as Map<String, dynamic>));
    }
    return histories;
  }
}