import 'dart:convert';
import 'dart:developer';

import 'package:prueba/data/sqliteDB.dart';
import 'package:prueba/domain/model/food_model.dart';
import 'package:prueba/domain/model/home_model.dart';

class HomeApi {

  Future<List<HomeModel>> getHome() async{
    var dbClient = await SqliteDB().db;
    var resData = await dbClient.rawQuery('SELECT * FROM ComidaAdquerida');
    List<HomeModel> list = resData.isNotEmpty
        ? resData.map((c) => HomeModel.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<FoodModel>> getFood() async{
    var dbClient = await SqliteDB().db;
    String estado = "0";
    var resData2 = await dbClient.rawUpdate("UPDATE Comida SET estado = '$estado'");
    var resData = await dbClient.rawQuery('SELECT * FROM Comida');
    List<FoodModel> list = resData.isNotEmpty
        ? resData.map((c) => FoodModel.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<FoodModel>> updateFood(String id) async{
    var dbClient = await SqliteDB().db;
    String estado = "1";
    var resData2 = await dbClient.rawUpdate("UPDATE Comida SET estado = '$estado' where id='$id'");
    var resData = await dbClient.rawQuery('SELECT * FROM Comida');
    List<FoodModel> list = resData.isNotEmpty
        ? resData.map((c) => FoodModel.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<FoodModel>> addFood(String nombre,String descripcion,String calorias,String estado,String img) async {
    var dbClient = await SqliteDB().db;
    dynamic user = {
      "nombre": nombre,
      "descripcion": descripcion,
      "calorias": calorias,
      "estado": estado,
      "img": img,
    };
    int res = await dbClient.insert("ComidaAdquerida", user);
    var resData = await dbClient.rawQuery('SELECT * FROM Comida');
    List<FoodModel> list = resData.isNotEmpty
        ? resData.map((c) => FoodModel.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<HomeModel>> deleteFoodId(String id) async {
    var dbClient = await SqliteDB().db;
    var res = await dbClient.rawDelete(
        "DELETE FROM ComidaAdquerida WHERE id='$id'");
    var resData = await dbClient.rawQuery('SELECT * FROM ComidaAdquerida');
    List<HomeModel> list = resData.isNotEmpty
        ? resData.map((c) => HomeModel.fromJson(c)).toList()
        : [];
    return list;
  }

}
