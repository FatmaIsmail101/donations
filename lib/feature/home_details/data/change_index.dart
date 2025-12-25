import 'package:flutter/cupertino.dart';

class ChangeIndexProvider extends InheritedWidget{
  const ChangeIndexProvider( {super.key, required super.child,
    required this.selectedIndex,required this.changeIndex, });
final int selectedIndex;
final Function(int) changeIndex;

static ChangeIndexProvider? of(BuildContext context){
  return context.dependOnInheritedWidgetOfExactType<ChangeIndexProvider>();
}
  @override
  bool updateShouldNotify( ChangeIndexProvider oldWidget) {
    return oldWidget.selectedIndex != selectedIndex;
  }
}