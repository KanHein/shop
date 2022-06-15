import 'package:flutter/material.dart';
import 'package:shop/data/shopping_cart.dart';
import 'package:shop/firestore_service/firestore_service.dart';

import '../models/item.dart';
import 'home_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final FirestoreService _service = FirestoreService();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          for(int i = 0; i< ShoppingCart.items.length; i++)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ShoppingCart.items[i].name!),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: (){
                              ShoppingCart.items[i].quantity = ShoppingCart.items[i].quantity! + 1;
                              setState(() {
                                ShoppingCart;
                              });
                            },
                            child: const Icon(Icons.arrow_drop_up, size: 18.0)),
                        const SizedBox(height: 10,),
                        GestureDetector(
                            onTap: (){
                              if(ShoppingCart.items[i].quantity! > 1){
                                ShoppingCart.items[i].quantity = ShoppingCart.items[i].quantity! - 1;
                                setState(() {
                                  ShoppingCart;
                                });
                              }
                            },
                            child: const Icon(Icons.arrow_drop_down, size: 18.0)),
                      ],
                    ),

                    Text(ShoppingCart.items[i].quantity.toString()),
                    Text(ShoppingCart.items[i].price.toString()),
                    Text((ShoppingCart.items[i].price! * ShoppingCart.items[i].quantity!).toString()),
                  ],
                ),
                const Divider(color: Colors.black, thickness: 0.8,),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total"),
              Text(getTotal().toString()),
            ],
          ),
          const Divider(color: Colors.black, thickness: 0.8,),
          const SizedBox(height: 16,),
          ElevatedButton(
              onPressed: () {
                if(!isLoading){
                  setState((){
                    isLoading = !isLoading;
                  });
                  _service.submitOrder(ShoppingCart.items).then((isSuccess){
                    if(isSuccess){
                      ShoppingCart.clearCart();
                      setState((){
                        isLoading = !isLoading;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false);
                    }
                  });

                }
          }, child: const Text("Order")),
        ],

      ),
    );
  }
  int getTotal()
  {
    int total = 0;
    for(Item item in ShoppingCart.items)
    {
      total += item.quantity! * item.price!;
    }
    return total;
  }
}

