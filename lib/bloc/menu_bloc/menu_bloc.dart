import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/models/menu_item.dart';
import 'package:shop/firestore_service/firestore_service.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState>
{
  MenuBloc() : super(MenuInitial()){
    final FirestoreService service = FirestoreService();
    on<GetMenuList>((event, emit) async
    {
      try{
        emit(MenuInitial());
        final menuItems = await service.menuItems();
        if(menuItems.isEmpty){
          emit(MenuEmpty());
        }
        emit(MenuSuccess(menuItems));
      }catch(e){
        emit(MenuError());
      }
    });
  }
}