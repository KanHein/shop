import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../firestore_service/firestore_service.dart';
import '../../models/order_history.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState>
{
  OrderHistoryBloc() : super(OrderHistoryInitial()){
    final FirestoreService service = FirestoreService();
    on<GetOrderHistoryList>((event, emit) async {
      try{
        emit(OrderHistoryLoading());
        final List<OrderHistory> orderHistories = await service.orderHistories();
        if(orderHistories.isEmpty){
          emit(OrderHistoryEmpty());
        }
        emit(OrderHistorySuccess(orderHistories));
      }catch(e){
        emit(OrderHistoryError());
      }
    });
  }
}