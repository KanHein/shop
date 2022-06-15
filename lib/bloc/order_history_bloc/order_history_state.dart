part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable
{
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState
{
  //
}

class OrderHistoryLoading extends OrderHistoryState
{
  //
}

class OrderHistorySuccess extends OrderHistoryState
{
  final List<OrderHistory> orderHistories;
  const OrderHistorySuccess(this.orderHistories);
}

class OrderHistoryEmpty extends OrderHistoryState
{
  //
}

class OrderHistoryError extends OrderHistoryState
{
  //
}