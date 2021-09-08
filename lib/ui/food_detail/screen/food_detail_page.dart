import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/data/repository/home_repository.dart';
import 'package:prueba/ui/food/screen/food_page.dart';
import 'package:prueba/ui/food_detail/bloc/food_detail_bloc.dart';
import 'package:prueba/ui/food_detail/bloc/food_detail_event.dart';
import 'package:prueba/ui/food_detail/bloc/food_detail_state.dart';
import 'package:prueba/ui/start_menu.dart';
import 'package:prueba/util/responsive.dart';
import 'package:intl/intl.dart';

class FoodDetailPageWidget extends StatefulWidget {
  String id;
  FoodDetailPageWidget({Key key, this.id}) : super(key: key);

  @override
  _FoodDetailPageWidgetState createState() => _FoodDetailPageWidgetState();
}

class _FoodDetailPageWidgetState extends State<FoodDetailPageWidget> {
  FoodDetailBloc _bloc;
  HomeRepository _repository;
  bool check1 = true;
  bool check2 = true;
  bool check3 = true;
  bool check4 = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository = HomeRepository();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_bloc == null) {
      _bloc = new FoodDetailBloc(repository: _repository);
      _bloc.add(FetchHome());
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Almuerzo', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: Container(
            //padding: const EdgeInsets.only(right: 10, left: 20, bottom: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      return Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) {
                            return FoodPageWidget();
                          }, transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return FadeTransition(opacity: animation, child: child);
                      }));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Atrás", style: TextStyle(color: Color(0XFF6B757D)),),
                              Container(
                                height: 1,
                                width: 35,
                                color: Color(0XFF6B757D),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
              ],
            )
        ),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.only(right: 10, left: 20, bottom: 10, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite_border, color: Color(0XFFA9A9A9),)
                              ],
                            ),
                          ),
                        ],
                      )
                  )
                ],
              )
          )
        ],
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is FoodDetailUnauthorized) {
            return Center(
              child: Text(state.message),
            );
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is FoodDetailConnectionError) {
              return Container();
            }

            if (state is FoodDetailUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FoodDetailError) {
              return Center(
                child: Text(state.message),
              );
            }

            return Column(
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        state is FoodDetailSuccess
                            ? Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                },
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.model.length,
                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          if(state.model[index].id.toString() == widget.id){
                                            return Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                          color: Color(0XFFE8E8E8)
                                                      )
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: responsive.hp(24),
                                                        width: responsive.width,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                            border: Border.all(
                                                                color: Color(0XFFE8E8E8)
                                                            ),
                                                            image: DecorationImage(
                                                                image: NetworkImage(state.model[index].img),
                                                                fit: BoxFit.fill
                                                            )
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(
                                                                state.model[index].nombre,
                                                                style: TextStyle(color: Color(0XFF211E1F), fontSize: 19, fontWeight: FontWeight.bold),
                                                              ),
                                                              SizedBox(height: 10,),
                                                              Container(
                                                                height: responsive.hp(4),
                                                                width: responsive.wp(26),
                                                                decoration: BoxDecoration(
                                                                  color:Color(0XFFe2f7df),
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  border: Border.all(
                                                                      color: Color(0XFFE8E8E8)
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Text("Recomendado", style: TextStyle(color: Color(0XFF35B266), fontSize: 14),)
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 10,),
                                                              Text(
                                                                "Ingredientes: "+state.model[index].descripcion,
                                                                style: TextStyle(color: Color(0XFF211E1F), fontSize: 15),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        //height: responsive.hp(24),
                                                        width: responsive.width,
                                                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          border: Border.all(
                                                              color: Color(0XFFE8E8E8)
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text("Kcal", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                  SizedBox(height: 5,),
                                                                  Text(state.model[index].calorias, style: TextStyle(color: Color(0XFF35B266), fontWeight: FontWeight.w600))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 2,
                                                                    height: 25,
                                                                    color: Color(0XFFE8E8E8),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text("Grasa", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                  SizedBox(height: 5,),
                                                                  Text("6g", style: TextStyle(color: Color(0XFF35B266), fontWeight: FontWeight.w600))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 2,
                                                                    height: 25,
                                                                    color: Color(0XFFE8E8E8),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text("Carbo", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                  SizedBox(height: 5,),
                                                                  Text("108g", style: TextStyle(color: Color(0XFF35B266), fontWeight: FontWeight.w600))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    width: 2,
                                                                    height: 25,
                                                                    color: Color(0XFFE8E8E8),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text("Prote", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                  SizedBox(height: 5,),
                                                                  Text("41g", style: TextStyle(color: Color(0XFF35B266), fontWeight: FontWeight.w600))
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  //height: responsive.hp(24),
                                                  width: responsive.width,
                                                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/icon/icon4.png"),
                                                                SizedBox(width: 5,),
                                                                Expanded(
                                                                  child: Text("Bajo en sodio", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(height: 10,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/icon/icon5.png", width: 15,),
                                                                SizedBox(width: 10,),
                                                                Expanded(
                                                                  child: Text("Sin lactosa", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/icon/icon6.png", width: 15,),
                                                                SizedBox(width: 5,),
                                                                Expanded(
                                                                  child: Text("Bajo en azúcar", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(height: 10,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/icon/icon7.png", width: 15,),
                                                                SizedBox(width: 10,),
                                                                Expanded(
                                                                  child: Text("Bajo en carbo", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/icon/icon8.png", width: 15,),
                                                                SizedBox(width: 5,),
                                                                Expanded(
                                                                  child: Text("Bajo en azúcar", style: TextStyle(color: Color(0XFFA9A9A9)),),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }else{
                                            return Container();
                                          }
                                        })
                                  ],
                                )
                            ),
                          ],
                        )
                            : Container(
                          height: MediaQuery.of(context).size.width,
                          child: CircularProgressIndicator(),
                          alignment: Alignment.center,
                        ),
                        state is FoodDetailSuccess
                            ? Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                },
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.model.length,
                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          if(state.model[index].id.toString() != widget.id){
                                            return Container(
                                              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: new BorderRadius.circular(10.0),
                                                  border: Border.all(
                                                      color: Color(0XFFE8E8E8)
                                                  )
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 3,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Container(
                                                              height: responsive.hp(11),
                                                              margin: const EdgeInsets.only(left: 5, right: 10, bottom: 5, top: 5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: new BorderRadius.circular(10.0),
                                                                  border: Border.all(
                                                                      color: Color(0XFFE8E8E8)
                                                                  ),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(state.model[index].img),
                                                                      fit: BoxFit.fill
                                                                  )
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              state.model[index].nombre,
                                                              style: TextStyle(color: Color(0XFF211E1F), fontSize: 14),
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Container(
                                                              height: responsive.hp(4),
                                                              width: responsive.wp(26),
                                                              decoration: BoxDecoration(
                                                                color:Color(0XFFe2f7df),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                border: Border.all(
                                                                    color: Color(0XFFE8E8E8)
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text("Recomendado", style: TextStyle(color: Color(0XFF35B266), fontSize: 14),)
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  state.model[index].calorias+'Kcal',
                                                                  style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 12),
                                                                ),
                                                                SizedBox(width: 5,),
                                                                Icon(Icons.info, size: 15,)
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                           state.model[index].estado!="0"
                                                           ? Column(
                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                             crossAxisAlignment: CrossAxisAlignment.center,
                                                             children: [
                                                               Text("pedido agregado", style: TextStyle(color: Color(0XFF606060), fontSize: 15))
                                                             ],
                                                           )
                                                               :GestureDetector(
                                                              onTap: (){
                                                                _bloc.add(FetchUpdate(id: state.model[index].id.toString()));
                                                                _bloc.add(Fetchadd(nombre: state.model[index].nombre, descripcion: state.model[index].descripcion, calorias: state.model[index].calorias, estado: state.model[index].calorias, img: state.model[index].img));
                                                              },
                                                              child: Container(
                                                                width: responsive.wp(25),
                                                                height: responsive.hp(5),
                                                                margin: const EdgeInsets.only(left: 5, right: 10, bottom: 5, top: 5),
                                                                decoration: BoxDecoration(
                                                                  color: Color(0XFFFFD538),
                                                                  borderRadius: new BorderRadius.circular(10.0),
                                                                  border: Border.all(
                                                                      color: Color(0XFFE8E8E8)
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Text("Agregar", style: TextStyle(color: Color(0XFF606060), fontSize: 15))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }else{
                                            return Container();
                                          }
                                        }),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: check1,
                                            activeColor: Color(0XFF54CE84),
                                            onChanged: (val){
                                              setState(() {
                                                check1 = !check1;
                                              });
                                            }
                                        ),
                                        Expanded(
                                          child: Text("Camote", style: TextStyle(color: Color(0XFF606060)),),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: check2,
                                            activeColor: Color(0XFF54CE84),
                                            onChanged: (val){
                                              setState(() {
                                                check2 = !check2;
                                              });
                                            }
                                        ),
                                        Expanded(
                                          child: Text("Papa", style: TextStyle(color: Color(0XFF606060)),),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: check3,
                                            activeColor: Color(0XFF54CE84),
                                            onChanged: (val){
                                              setState(() {
                                                check3 = !check3;
                                              });
                                            }
                                        ),
                                        Expanded(
                                          child: Text("Arroz", style: TextStyle(color: Color(0XFF606060)),),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: check4,
                                            activeColor: Color(0XFF54CE84),
                                            onChanged: (val){
                                              setState(() {
                                                check4 = !check4;
                                              });
                                            }
                                        ),
                                        Expanded(
                                          child: Text("Arroz", style: TextStyle(color: Color(0XFF606060)),),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                            ),
                          ],
                        )
                            : Container(
                          height: MediaQuery.of(context).size.width,
                          child: CircularProgressIndicator(),
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                state is FoodDetailSuccess
                    ? Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                        },
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.model.length,
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if(state.model[index].id.toString() == widget.id){
                                    return Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              _bloc.add(Fetchadd(nombre: state.model[index].nombre, descripcion: state.model[index].descripcion, calorias: state.model[index].calorias, estado: state.model[index].calorias, img: state.model[index].img));
                                              return Navigator.of(context).pushReplacement(PageRouteBuilder(
                                                  pageBuilder: (BuildContext context, _, __) {
                                                    return StartMenuWidget(page: 1,);
                                                  }, transitionsBuilder:
                                                  (_, Animation<double> animation, __, Widget child) {
                                                return FadeTransition(opacity: animation, child: child);
                                              }));
                                            },
                                            child: Container(
                                              width: responsive.wp(90),
                                              height: responsive.hp(6),
                                              margin: const EdgeInsets.only(left: 5, right: 10, bottom: 20, top: 5),
                                              decoration: BoxDecoration(
                                                color: Color(0XFFFFD538),
                                                borderRadius: new BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: Color(0XFFE8E8E8)
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("Agregar", style: TextStyle(color: Color(0XFF606060), fontSize: 15))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }else{
                                    return Container();
                                  }
                                })
                          ],
                        )
                    ),
                  ],
                )
                    : Container(
                  height: MediaQuery.of(context).size.width,
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
