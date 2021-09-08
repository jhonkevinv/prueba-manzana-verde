import 'package:flutter/material.dart';
import 'package:prueba/ui/home/screen/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class StartMenuWidget extends StatefulWidget {
  int page;
  StartMenuWidget({Key key, this.page}) : super(key: key);
  @override
  _StartMenuWidgetState createState() => _StartMenuWidgetState();
}

class _StartMenuWidgetState extends State<StartMenuWidget> {

  _selectTab(int pos) {
    switch (pos) {
      case 0:
        return HomePageWidget();
      case 1:
        return HomePageWidget();
      case 2:
        return HomePageWidget();
      case 3:
        return HomePageWidget();
      default:
        return Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            minWidth: 60,
                            onPressed: (){
                              setState(() {
                                widget.page = 0;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: widget.page == 0? Color(0XFF35B266): Colors.grey,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Hoy", style: TextStyle(color: widget.page == 0? Color(0XFF35B266): Colors.grey,),)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            minWidth: 60,
                            onPressed: (){
                              setState(() {
                                widget.page = 1;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_alert,
                                  color: widget.page == 1? Color(0XFF35B266): Colors.grey,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Mis pedidos", style: TextStyle(color: widget.page == 1? Color(0XFF35B266): Colors.grey,),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            minWidth: 60,
                            onPressed: (){
                              setState(() {
                                widget.page = 2;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.food_bank,
                                  color: widget.page == 2? Color(0XFF35B266): Colors.grey,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Comidas", style: TextStyle(color: widget.page == 2? Color(0XFF35B266): Colors.grey,),)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            minWidth: 60,
                            onPressed: (){
                              setState(() {
                                widget.page = 3;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: widget.page == 3? Color(0XFF35B266): Colors.grey,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("coach", style: TextStyle(color: widget.page == 3? Color(0XFF35B266): Colors.grey,),)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                shape: CircularNotchedRectangle(),
                notchMargin: 10,
              ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Color(0XFF35B266),
                  child: Icon(Icons.add),
                  onPressed: () {},
                ),
              body: _selectTab(widget.page)
            )
        )
    );
  }
}