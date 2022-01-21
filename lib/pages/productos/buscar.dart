import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yavi/conf/productos_provider.dart';
import 'package:yavi/models/producto.dart';
import 'package:yavi/widgets/producto_view.dart';

class BuscarProductoPage extends StatefulWidget {
  const BuscarProductoPage({Key? key}) : super(key: key);

  @override
  _BuscarProductoPageState createState() => _BuscarProductoPageState();
}

class _BuscarProductoPageState extends State<BuscarProductoPage> {
  final buscarController = TextEditingController();
  late Widget _listafiltrada;
  ProductoProvider productoprovider = ProductoProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listafiltrada = const Text("Filtro");
  }

  cambioBody(cambio) {
    setState(() {
      _listafiltrada = cambio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => buscarProductos(value),
          controller: buscarController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Buscar",
          ),
        ),
      ),
      body: _listafiltrada,
    );
  }

  buscarProductos(value) async {
    final mapas = await productoprovider.getProductoFilter(value);
    Widget wigetProductos = ListView.builder(
        itemCount: mapas.length,
        itemBuilder: (context, index) {
          Producto producto = Producto.fromMap(mapas[index]);
          return productoView(producto);
        });

    cambioBody(wigetProductos);
  }
}
