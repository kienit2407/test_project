import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigatorCubit extends Cubit<int> {
  TabNavigatorCubit() : super(0);

  void changeNavigator(int index) {
    if (index < 0 || index >= 5) return;
    emit(index);
  }
}
