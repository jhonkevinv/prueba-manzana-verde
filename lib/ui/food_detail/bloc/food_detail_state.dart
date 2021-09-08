import 'package:meta/meta.dart';
import 'package:prueba/domain/model/food_model.dart';

@immutable
abstract class FoodDetailState {
  FoodDetailState([List props = const []]) : super();
}

class FoodDetailUninitialized extends FoodDetailState {
  @override
  String toString() => 'AssistanceUninitialized';

  List<Object> get props => [];
}

class FoodDetailLoading extends FoodDetailState {
  @override
  String toString() => 'AssistanceLoading';

  List<Object> get props => [];
}

class FoodDetailSuccess extends FoodDetailState {
  final List<FoodModel> model;

  FoodDetailSuccess({this.model}) : super([model]);

  FoodDetailSuccess copyWith({
    FoodModel model,
  }) {
    return FoodDetailSuccess(
      model: model ?? this.model,
    );
  }

  @override
  String toString() => 'AssistanceSuccess';

  @override
  // TODO: implement props
  List<Object> get props => [model];
}

class FoodDetailUpdateSuccess extends FoodDetailState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  String toString() => 'AssistanceSuccess';
}
class FoodDetailAddSuccess extends FoodDetailState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  String toString() => 'AssistanceSuccess';
}

class FoodDetailError extends FoodDetailState {
  final String message;

  FoodDetailError({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceError { message: $message }';
}

class FoodDetailUnauthorized extends FoodDetailState {
  final String message;

  FoodDetailUnauthorized({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceUnauthorized { message: $message }';
}

class FoodDetailConnectionError extends FoodDetailState {
  final String message;

  FoodDetailConnectionError({@required this.message}) : super([message]);

  List<Object> get props => [message];

  @override
  String toString() => 'AssistanceUnauthorized { message: $message }';
}
