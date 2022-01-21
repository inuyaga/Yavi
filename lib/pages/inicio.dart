import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yavi/controller/selected.dart';

import 'package:yavi/pages/productos.dart';
import 'package:yavi/pages/productos/buscar.dart';
import 'package:yavi/pages/ventas.dart';
import 'package:yavi/widgets/bottom_navigator.dart';

class Inicio extends StatelessWidget {
  final selecController = Get.put(SelectedController());
  static List<Widget> pagesOptions = <Widget>[
    ProductosPage(),
    VentasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuscarProductoPage()));
                  },
                  icon: const Icon(Icons.search))
            ],
            centerTitle: true,
            title: const Text(
              "Yavi App",
            )),
        body: Obx(() => pagesOptions.elementAt(selecController.selected.value)),
        bottomNavigationBar: const ButtonNavigations());
  }
}
