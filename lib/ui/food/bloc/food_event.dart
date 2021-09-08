import 'package:meta/meta.dart';

@immutable
abstract class FoodEvent {
  FoodEvent([List props = const []]) : super();
}

class FetchHome extends FoodEvent {
  List<Object> get props => [];

  @override
  String toString() => 'FetchAssistance';
}
