import 'package:prueba/data/api/home_api.dart';
import 'package:prueba/domain/model/food_model.dart';
import 'package:prueba/domain/model/home_model.dart';

class HomeRepository{
  final _apiProvider = HomeApi();

  Future<List<HomeModel>> getAssistance() => _apiProvider.getHome();
  Future<List<FoodModel>> getFood() => _apiProvider.getFood();
  Future<List<FoodModel>> updateFood({String id,}) => _apiProvider.updateFood(id);
  Future<List<FoodModel>> addFood({String nombre,String descripcion,String calorias,String estado,String img}) => _apiProvider.addFood(nombre, descripcion, calorias, estado, img);
  Future<List<HomeModel>> getdeleteFood({String id}) => _apiProvider.deleteFoodId(id);

}