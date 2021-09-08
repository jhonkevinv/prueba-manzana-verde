import 'package:flutter/material.dart';
import 'package:prueba/data/sqliteDB.dart';
import 'package:prueba/ui/start_menu.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:eyro_toast/eyro_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  EyroToastSetup.shared.navigatorKey = GlobalKey<NavigatorState>();
  final db = SqliteDB();
  await db.countTable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: EyroToastSetup.shared.navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenn(),
    );
  }
}

class SplashScreenn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreennState();
  }
}

class SplashScreennState extends State<SplashScreenn> {

  @override
  void initState() {
    super.initState();
    createUserTable();
  }

  Future createUserTable() async {
    var dbClient = await SqliteDB().db;
    var res = await dbClient.execute("""
      CREATE TABLE IF NOT EXISTS Comida(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        descripcion TEXT,
        calorias TEXT,
        estado TEXT,
        img TEXT
      )""");

    var res2 = await dbClient.execute("""
      CREATE TABLE IF NOT EXISTS ComidaAdquerida(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        descripcion TEXT,
        calorias TEXT,
        estado TEXT,
        img TEXT
      )""");

    final List = await dbClient.rawQuery("SELECT * FROM Comida");
    if (List.length == 0) {
      AddUserData();
    }
    return res;
  }

  Future AddUserData() async {
    var Comidas = [
      {
        "nombre": "Pescado escalfado con trigo",
        "descripcion": "Delicioso plato de pasta con pollo, verduras salteadas y chía.",
        "calorias": "800",
        "estado": "0",
        "img": "https://pescado.site/wp-content/uploads/2020/10/Pescado-escalfado-con-mantequilla-3.webp"
      },
      {
        "nombre": "Ensalada de quinua y beterraga",
        "descripcion": "rica ensalada preparada al instante.",
        "calorias": "200",
        "estado": "0",
        "img": "https://pescado.site/wp-content/uploads/2020/10/Pescado-escalfado-con-mantequilla-3.webp"
      }
    ];
    final dbClient = await SqliteDB().db;

    /// Initialize batch
    final batch = dbClient.batch();

    /// Batch insert
    for (var i = 0; i < Comidas.length; i++) {
      batch.insert("Comida", Comidas[i]);
    }

    /// Commit
    await batch.commit(noResult: true);
    return "success";
  }

  // Future delete() async {
  //   var dbClient = await SqliteDB().db;
  //   var res = await dbClient.rawQuery("""DROP TABLE User; """);
  //   var resData = await dbClient.rawQuery("""DROP TABLE UserData; """);
  //   return res;
  // }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: StartMenuWidget(page: 1,),
        image: Image.asset(
          'assets/icon/icon.jpg',
          height: 150,
          width: 150,
        ),
        backgroundColor: Colors.white,
        photoSize: 100.0,
        loaderColor: Colors.black45);
  }
}
