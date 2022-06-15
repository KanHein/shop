import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/order_history_bloc/order_history_bloc.dart';
import '../models/order_history.dart';
import '../widgets/history_shimmer.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final OrderHistoryBloc _historyBloc = OrderHistoryBloc();
  @override
  void initState()
  {
    super.initState();
    _historyBloc.add(GetOrderHistoryList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Histories"),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (_) => _historyBloc,
              child: BlocListener<OrderHistoryBloc, OrderHistoryState>(
                listener: (context, state){
                  if(state is OrderHistoryError)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Loading Error"),
                      ),
                    );
                  }
                },
                child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
                  builder: (context, state){
                    if(state is OrderHistoryInitial){
                      return const HistoryShimmer();
                    }else if(state is OrderHistoryLoading){
                      return const HistoryShimmer();
                    }else if(state is OrderHistoryEmpty){
                      return const Center(
                        child: Text("Empty, No Data"),
                      );
                    }else if(state is OrderHistorySuccess){
                      return historyCard(state.orderHistories);
                    }else if(state is OrderHistoryError){
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
  Widget historyCard(List<OrderHistory> histories)
  {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: histories.length,
      itemBuilder: (context, index){
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(histories[index].date!,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for(int i = 0; i < histories[index].orders!.length; i++)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(histories[index].orders![i].name!),
                    Text(histories[index].orders![i].quantity.toString()),
                    Text(histories[index].orders![i].price.toString()),
                    Text((histories[index].orders![i].price! * histories[index].orders![i].quantity!).toString()),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );

  }
}