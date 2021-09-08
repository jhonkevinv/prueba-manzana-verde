import 'package:meta/meta.dart';

@immutable
abstract class FoodDetailEvent {
  FoodDetailEvent([List props = const []]) : super();
}

class FetchHome extends FoodDetailEvent {
  List<Object> get props => [];

  @override
  String toString() => 'FetchAssistance';
}

class FetchUpdate extends FoodDetailEvent {
  String id;
  List<Object> get props => [id];
  FetchUpdate(
      {this.id,}) : super();

  @override
  String toString() => 'FetchAssistance';
}

class Fetchadd extends FoodDetailEvent {
  String nombre, descripcion, calorias, estado, img;
  List<Object> get props => [nombre, descripcion, calorias, estado, img];
  Fetchadd(
      {this.nombre, this.descripcion, this.calorias, this.estado, this.img}) : super();

  @override
  String toString() => 'FetchAssistance';
}
