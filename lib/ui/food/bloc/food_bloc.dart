import 'package:bloc/bloc.dart';
import 'package:prueba/data/network/network_exception.dart';
import 'package:prueba/data/repository/home_repository.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final HomeRepository repository;

  FoodBloc({this.repository,})  : assert(repository != null);
  //HomeBloc({this.repository}) : super(HomeUninitialized);

  @override
  // TODO: implement initialState
  FoodState get initialState => FoodUninitialized();

  @override
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchHome) {
      yield FoodLoading();
      try {
        print("buscando datos");
        final result = await repository.getFood();
        print(result);
        yield FoodSuccess(model: result);
      } on Exception catch (e) {
        if (e is NetworkException) {
          print("error 1");
          yield FoodConnectionError(message: e.toString());
        } else {
          print("error 2");
          print(e.toString());
          yield FoodError(message: e.toString());
        }
      }
    }
  }
}
