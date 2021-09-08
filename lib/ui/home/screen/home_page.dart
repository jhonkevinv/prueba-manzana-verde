import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:prueba/data/repository/home_repository.dart';
import 'package:prueba/ui/food/screen/food_page.dart';
import 'package:prueba/ui/home/bloc/home_bloc.dart';
import 'package:prueba/ui/home/bloc/home_event.dart';
import 'package:prueba/ui/home/bloc/home_state.dart';
import 'package:prueba/util/responsive.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  HomeBloc _bloc;
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
      _bloc = new HomeBloc(repository: _repository);
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
        actions: <Widget>[
          Container(
            width: responsive.wp(55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icon/profile.png")
                                  )
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Text("Mis pedidos", style: TextStyle(color: Colors.black, fontSize: responsive.dp(2.1)),),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
              width: responsive.wp(40),
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
                            width: 23,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/icon/numero.png")
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("2", style: TextStyle(color: Colors.black),)
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  GestureDetector(
                      onTap: (){
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/icon/auto.png", width: 55,)
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  GestureDetector(
                      onTap: (){
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/icon/config.png", width: 33,)
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
          if (state is HomeUnauthorized) {
            return Center(
              child: Text(state.message),
            );
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is HomeConnectionError) {
              return Container();
            }

            if (state is HomeUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Text(state.message),
              );
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("0Kcal", textAlign: TextAlign.start, style: TextStyle(fontSize: 14),),
                            ),
                            Expanded(
                              child: Text("22000Kcal", textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),
                            )
                          ],
                        ),
                        Divider(thickness: 5),
                      ],
                    ),
                  ),
                  Divider(thickness: 1),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: CalendarCarousel(
                          thisMonthDayBorderColor: Colors.transparent,
                          height: 90.0,
                          selectedDateTime: DateTime.now(),
                          showHeader: false,
                          daysHaveCircularBorder: false,
                          showHeaderButton: false,
                          weekFormat: true,
                          weekdayTextStyle: TextStyle(
                              color: Color(0XFFC9C9C9),
                              fontSize: 16,),
                          selectedDayTextStyle: TextStyle(
                            color: Colors.black,
                            decorationColor: Colors.blue,
                          ),
                          todayTextStyle: TextStyle(color: Colors.white),
                          locale: 'es_ES',
                          onDayPressed: (DateTime date, list) {
                            // if (_currentDate != date) {
                            //   _currentDate = date;
                            //   String dateFormat =
                            //       _currentDate.day.toString().padLeft(2, "0") +
                            //           "/" +
                            //           _currentDate.month.toString().padLeft(2, "0") +
                            //           "/" +
                            //           _currentDate.year.toString();
                            //   _page = 1;
                            //   _bloc?.add(FetchHistory(
                            //       page: _page,
                            //       fromDate: dateFormat,
                            //       toDate: dateFormat,
                            //       isFiltered: true));
                            // }
                            // setState(() {});
                          },
                          todayButtonColor: Color(0XFF35B266),
                          todayBorderColor: Colors.transparent,
                          selectedDayBorderColor: Colors.transparent,
                          selectedDayButtonColor: Color(0XFFFFD538),
                        ),
                      ),
                      Divider(thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: responsive.hp(4),
                                  margin: const EdgeInsets.only(left: 20, right: 35, bottom: 5, top: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/icon/entrega.png"),
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
                                  "Entregar en:",
                                  style: TextStyle(color: Color(0XFF606060), fontSize: 14),
                                ),
                                SizedBox(height: responsive.hp(1),),
                                Text(
                                  "Av Mariscal Ramón Castilla 1155",
                                  style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color(0XFF606060),
                                  size: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(thickness: 1),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
                    decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: new BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Color(0XFFE8E8E8)
                        )
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: responsive.hp(7),
                                    margin: const EdgeInsets.only(left: 5, right: 20, bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("assets/icon/apple.png"),
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
                                    "Media mañana",
                                    style: TextStyle(color: Color(0XFF606060), fontSize: 14),
                                  ),
                                  SizedBox(height: responsive.hp(1),),
                                  Text(
                                    '200Kcal',
                                    style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 5, right: 10, bottom: 5, top: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("No tienes créditos", style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 15))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  state is HomeSuccess
                      ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {
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
                                state.model.length != 0?ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.model.length,
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      style: TextStyle(color: Color(0XFF35B266), fontSize: 14),
                                                    ),
                                                    SizedBox(height: responsive.hp(1),),
                                                    Text(
                                                      state.model[index].calorias+'Kcal',
                                                      style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap:(){
                                                        _bloc.add(FetchDeleteHome(id: state.model[index].id.toString()));
                                                      },
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(thickness: 1),
                                        ],
                                      );
                                    })
                                    :Container(
                                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: responsive.hp(7),
                                                  margin: const EdgeInsets.only(left: 5, right: 20, bottom: 5, top: 5),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/icon/almuerzo.png"),
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
                                                  "Almuerzo",
                                                  style: TextStyle(color: Color(0XFF35B266), fontSize: 14),
                                                ),
                                                SizedBox(height: responsive.hp(1),),
                                                Text(
                                                  '800Kcal',
                                                  style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => FoodPageWidget(),));
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
                                )
                              ],
                            )
                        ),
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
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
                    decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: new BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Color(0XFFE8E8E8)
                        )
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: responsive.hp(7),
                                    margin: const EdgeInsets.only(left: 5, right: 20, bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("assets/icon/apple.png"),
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
                                    "Media tarde",
                                    style: TextStyle(color: Color(0XFF606060), fontSize: 14),
                                  ),
                                  SizedBox(height: responsive.hp(1),),
                                  Text(
                                    '200Kcal',
                                    style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 5, right: 10, bottom: 5, top: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("No tienes créditos", style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 15))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
                    decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: new BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Color(0XFFE8E8E8)
                        )
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: responsive.hp(7),
                                    margin: const EdgeInsets.only(left: 5, right: 20, bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("assets/icon/apple.png"),
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
                                    "Cena",
                                    style: TextStyle(color: Color(0XFF606060), fontSize: 14),
                                  ),
                                  SizedBox(height: responsive.hp(1),),
                                  Text(
                                    '800Kcal',
                                    style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 5, right: 10, bottom: 5, top: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("No tienes créditos", style: TextStyle(color: Color(0XFFA9A9A9), fontSize: 15))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
