import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop/bloc/menu_bloc/menu_bloc.dart';
import 'package:shop/data/shopping_cart.dart';
import 'package:shop/screens/order_screen.dart';
// import '../firestore_service/firestore_service.dart';
import '../widgets/item_shimmer.dart';
import 'order_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final FirestoreService _service = FirestoreService();
  final MenuBloc _menuBloc = MenuBloc();
  @override
  void initState() {
    super.initState();
    _menuBloc.add(GetMenuList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
                },
                child: const Icon(Icons.history_outlined)),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                if(ShoppingCart.items.isNotEmpty){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderScreen()));
                }
              },
              child: Stack(
                children: [
                  const Positioned(
                    child: Center(child: Icon(Icons.shopping_cart)),
                  ),
                  Positioned(
                    top: 10,
                    left: 13,
                    child: Text(
                      ShoppingCart.items.length.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (_) => _menuBloc,
              child: BlocListener<MenuBloc, MenuState>(
                listener: (context, state) {
                  if (state is MenuError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Loading Error"),
                      ),
                    );
                  }
                },
                child: BlocBuilder<MenuBloc, MenuState>(
                  builder: (context, state) {
                    if (state is MenuInitial) {
                      return const ItemShimmer();
                    } else if (state is MenuLoading) {
                      return const ItemShimmer();
                    } else if (state is MenuSuccess) {
                      return ListView.builder(
                          itemCount: state.menuItems.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              leading: GestureDetector(
                                onTap: () {
                                  ShoppingCart.addToCart(
                                      state.menuItems[index]);
                                  setState((){
                                    ShoppingCart;
                                  });
                                },
                                child: ShoppingCart.checkItem(
                                        state.menuItems[index])
                                    ?  const Icon(Icons.check_box)
                                    :const Icon(Icons.check_box_outline_blank),
                              ),
                              title: Text(state.menuItems[index].name!),
                              subtitle:
                                  Text(state.menuItems[index].price.toString()),
                              // trailing: const Icon(Icons.add),
                              children: <Widget>[
                                for (int i = 0;
                                    i <
                                        state.menuItems[index].variationItems!
                                            .length;
                                    i++)
                                  ListTile(
                                    leading: ShoppingCart.checkItem(state
                                            .menuItems[index]
                                            .variationItems![i])
                                        ? const Icon(Icons.check_box)
                                        : const Icon(
                                      Icons.check_box_outline_blank),
                                    title: Text(state.menuItems[index]
                                        .variationItems![i].name!),
                                    subtitle: Text(state.menuItems[index]
                                        .variationItems![i].price
                                        .toString()),
                                    onTap: () {
                                      ShoppingCart.addToCart(state
                                          .menuItems[index].variationItems![i]);
                                      setState((){
                                        ShoppingCart;
                                      });
                                    },
                                  ),
                              ],
                            );
                          });
                    } else if (state is MenuEmpty) {
                      return const Center(
                        child: Text("Empty"),
                      );
                    } else if (state is MenuError) {
                      return const Center(
                        child: Text("No load data, Error :("),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
