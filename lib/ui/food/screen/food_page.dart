import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/data/repository/home_repository.dart';
import 'package:prueba/ui/food/bloc/food_bloc.dart';
import 'package:prueba/ui/food/bloc/food_event.dart';
import 'package:prueba/ui/food/bloc/food_state.dart';
import 'package:prueba/ui/food_detail/screen/food_detail_page.dart';
import 'package:prueba/ui/start_menu.dart';
import 'package:prueba/util/responsive.dart';
import 'package:intl/intl.dart';

class FoodPageWidget extends StatefulWidget {
  const FoodPageWidget({Key key}) : super(key: key);

  @override
  _FoodPageWidgetState createState() => _FoodPageWidgetState();
}

class _FoodPageWidgetState extends State<FoodPageWidget> {
  FoodBloc _bloc;
  HomeRepository _repository;

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
      _bloc = new FoodBloc(repository: _repository);
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
                            return StartMenuWidget(page: 1,);
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
                                Text(DateFormat('EEEE').format(DateTime.now()), style: TextStyle(color: Colors.black),),
                                Text(DateFormat('dd').format(DateTime.now()), style: TextStyle(color: Colors.black),)
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
          if (state is FoodUnauthorized) {
            return Center(
              child: Text(state.message),
            );
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is FoodConnectionError) {
              return Container();
            }

            if (state is FoodUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FoodError) {
              return Center(
                child: Text(state.message),
              );
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  state is FoodSuccess
                      ? Column(
                    children: [
                      GestureDetector(
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.model.length,
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      return Navigator.of(context).pushReplacement(PageRouteBuilder(
                                          pageBuilder: (BuildContext context, _, __) {
                                            return FoodDetailPageWidget(
                                              id: state.model[index].id.toString(),
                                            );
                                          }, transitionsBuilder:
                                          (_, Animation<double> animation, __, Widget child) {
                                        return FadeTransition(opacity: animation, child: child);
                                      }));
                                    },
                                    child: Container(
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
                                          Container(
                                            height: responsive.hp(24),
                                            width: responsive.width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10.0),
                                                    topRight: Radius.circular(10.0)),
                                                border: Border.all(
                                                    color: Color(0XFFE8E8E8)
                                                ),
                                                image: DecorationImage(
                                                    image: NetworkImage(state.model[index].img),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        state.model[index].nombre,
                                                        style: TextStyle(color: Color(0XFF35B266), fontSize: 17),
                                                        textAlign: TextAlign.center,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Container(
                                                        height: responsive.hp(5),
                                                        width: responsive.wp(26),
                                                        decoration: BoxDecoration(
                                                          color:Color(0XFFe2f7df),
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(10.0),
                                                              bottomRight: Radius.circular(10.0)),
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
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        state.model[index].calorias+'Kcal',
                                                        style: TextStyle(color: Color(0XFF606060), fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Image.asset("assets/icon/icon1.png", width: 16,),
                                                      SizedBox(width: 10,),
                                                      Image.asset("assets/icon/icon2.png", width: 16,),
                                                      SizedBox(width: 10,),
                                                      Image.asset("assets/icon/icon3.png", width: 16,)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
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
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
