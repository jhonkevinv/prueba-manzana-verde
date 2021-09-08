class HomeModel {
  int id;
  String nombre, descripcion, calorias, estado, img;

  HomeModel({this.id, this.nombre, this.descripcion, this.calorias, this.estado, this.img});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
      id: json['id']??0,
      nombre: json["nombre"]??"",
      descripcion: json["descripcion"]??"",
      calorias: json["calorias"]??"",
      estado: json["estado"]??"",
      img: json["img"]??"",
    );

  @override
  // TODO: implement props
  List<Object> get props => [id, nombre, descripcion, calorias, estado, img];
}