import 'package:bloc/bloc.dart';
import 'package:prueba/data/network/network_exception.dart';
import 'package:prueba/data/repository/home_repository.dart';
import 'food_detail_event.dart';
import 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final HomeRepository repository;

  FoodDetailBloc({this.repository,})  : assert(repository != null);
  //HomeBloc({this.repository}) : super(HomeUninitialized);

  @override
  // TODO: implement initialState
  FoodDetailState get initialState => FoodDetailUninitialized();

  @override
  Stream<FoodDetailState> mapEventToState(FoodDetailEvent event) async* {
    print(event);
    // TODO: implement mapEventToState
    if (event is FetchHome) {
      yield FoodDetailLoading();
      try {
        final result = await repository.getFood();
        print(result);
        yield FoodDetailSuccess(model: result);
      } on Exception catch (e) {
        if (e is NetworkException) {
          yield FoodDetailConnectionError(message: e.toString());
        } else {
          print(e.toString());
          yield FoodDetailError(message: e.toString());
        }
      }
    }

    if (event is FetchUpdate) {
      yield FoodDetailLoading();
      try {
        final result = await repository.updateFood(id: event.id.toString());
        print(result);
        yield FoodDetailSuccess(model: result);
      } on Exception catch (e) {
        if (e is NetworkException) {
          yield FoodDetailConnectionError(message: e.toString());
        } else {
          print(e.toString());
          yield FoodDetailError(message: e.toString());
        }
      }
    }

    if (event is Fetchadd) {
      yield FoodDetailLoading();
      try {
        final result = await repository.addFood(nombre: event.nombre, descripcion: event.descripcion, calorias: event.calorias, estado: event.estado, img: event.img);
        print(result);
        yield FoodDetailSuccess(model: result);
      } on Exception catch (e) {
        if (e is NetworkException) {
          yield FoodDetailConnectionError(message: e.toString());
        } else {
          print(e.toString());
          yield FoodDetailError(message: e.toString());
        }
      }
    }

  }
}
