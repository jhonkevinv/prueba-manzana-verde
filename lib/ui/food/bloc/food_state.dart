import 'package:meta/meta.dart';
import 'package:prueba/domain/model/food_model.dart';

@immutable
abstract class FoodState {
  FoodState([List props = const []]) : super();
}

class FoodUninitialized extends FoodState {
  @override
  String toString() => 'AssistanceUninitialized';

  List<Object> get props => [];
}

class FoodLoading extends FoodState {
  @override
  String toString() => 'AssistanceLoading';

  List<Object> get props => [];
}

class FoodSuccess extends FoodState {
  final List<FoodModel> model;

  FoodSuccess({this.model}) : super([model]);

  FoodSuccess copyWith({
    FoodModel model,
  }) {
    return FoodSuccess(
      model: model ?? this.model,
    );
  }

  @override
  String toString() => 'AssistanceSuccess';

  @override
  // TODO: implement props
  List<Object> get props => [model];
}

class FoodError extends FoodState {
  final String message;

  FoodError({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceError { message: $message }';
}

class FoodUnauthorized extends FoodState {
  final String message;

  FoodUnauthorized({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceUnauthorized { message: $message }';
}

class FoodConnectionError extends FoodState {
  final String message;

  FoodConnectionError({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceUnauthorized { message: $message }';
}
