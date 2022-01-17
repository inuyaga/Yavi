import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yavi/controller/selected.dart';

class ButtonNavigations extends StatefulWidget {
  const ButtonNavigations({Key? key}) : super(key: key);

  @override
  _ButtonNavigationsState createState() => _ButtonNavigationsState();
}

class _ButtonNavigationsState extends State<ButtonNavigations> {
  int _selectIndex = 0;
  final SelectedController c = Get.find();

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
      c.selected.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Productos"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Venta"),
      ],
      currentIndex: _selectIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.amber,
    );
  }
}
