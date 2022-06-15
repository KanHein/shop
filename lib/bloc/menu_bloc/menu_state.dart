part of 'menu_bloc.dart';

abstract class MenuState extends Equatable
{
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState{}

class MenuLoading extends MenuState{}

class MenuSuccess extends MenuState
{
  final List<MenuItem> menuItems;
  const MenuSuccess(this.menuItems);
}

class MenuEmpty extends MenuState{}

class MenuError extends MenuState{}