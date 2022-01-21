class Producto {
  late int id;
  late String nombre;
  late double precio;
  late double precioCosto;
  late String descripcion;
  late String img;
  late String codebar;

  Producto(
      {required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.precioCosto,
      required this.img,
      required this.codebar});

  Map<String, dynamic> toMap() {
    return {
      "nombre": nombre,
      "precio": precio,
      "precioCosto": precioCosto,
      "descripcion": descripcion,
      "img": img,
      "codebar": codebar,
    };
  }

  Producto.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nombre = map['nombre'];
    descripcion = map['descripcion'];
    precio = map['precio'];
    precioCosto = map['precioCosto'];
    img = "${map['img']}";
    codebar = map['codebar'];
  }
}
