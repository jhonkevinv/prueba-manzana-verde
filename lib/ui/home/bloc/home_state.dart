import 'package:meta/meta.dart';
import 'package:prueba/domain/model/home_model.dart';

@immutable
abstract class HomeState {
  HomeState([List props = const []]) : super();
}

class HomeUninitialized extends HomeState {
  @override
  String toString() => 'AssistanceUninitialized';

  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  String toString() => 'AssistanceLoading';

  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  final List<HomeModel> model;

  HomeSuccess({this.model}) : super([model]);

  HomeSuccess copyWith({
    HomeModel model,
  }) {
    return HomeSuccess(
      model: model ?? this.model,
    );
  }

  @override
  String toString() => 'AssistanceSuccess';

  @override
  // TODO: implement props
  List<Object> get props => [model];
}

class HomeError extends HomeState {
  final String message;

  HomeError({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceError { message: $message }';
}

class HomeUnauthorized extends HomeState {
  final String message;

  HomeUnauthorized({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceUnauthorized { message: $message }';
}

class HomeConnectionError extends HomeState {
  final String message;

  HomeConnectionError({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceUnauthorized { message: $message }';
}
