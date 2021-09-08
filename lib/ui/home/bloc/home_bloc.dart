import 'package:bloc/bloc.dart';
import 'package:prueba/data/network/network_exception.dart';
import 'package:prueba/data/repository/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({this.repository,})  : assert(repository != null);
  //HomeBloc({this.repository}) : super(HomeUninitialized);

  @override
  // TODO: implement initialState
  HomeState get initialState => HomeUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchHome) {
      yield HomeLoading();
      try {
        final result = await repository.getAssistance();
        yield HomeSuccess(model: result);
      } on Exception catch (e) {
        if (e is NetworkException) {
          yield HomeConnectionError(message: e.toString());
        } else {
          yield HomeError(message: e.toString());
        }
      }
    }
    if (event is FetchDeleteHome) {
      yield HomeLoading();
      try {
        final result = await repository.getdeleteFood(id: event.id.toString());
        yield HomeSuccess(model: result);
      } on Exception catch (e) {
        if (e is NetworkException) {
          yield HomeConnectionError(message: e.toString());
        } else {
          print(e.toString());
          yield HomeError(message: e.toString());
        }
      }
    }
  }
}
