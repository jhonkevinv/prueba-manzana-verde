import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  HomeEvent([List props = const []]) : super();
}

class FetchHome extends HomeEvent {
  List<Object> get props => [];

  @override
  String toString() => 'FetchAssistance';
}
class FetchDeleteHome extends HomeEvent {
  String id;
  List<Object> get props => [id];
  FetchDeleteHome(
      {this.id,}) : super();

  @override
  String toString() => 'FetchAssistance';
}
