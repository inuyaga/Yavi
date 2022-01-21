import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yavi/models/producto.dart';

Widget productoView(Producto producto) {
  return ListTile(
    leading: Image.file(File(producto.img)),
    title: Text(producto.nombre),
    subtitle: Text(producto.descripcion),
    trailing: Text("${producto.precio}"),
  );
}
