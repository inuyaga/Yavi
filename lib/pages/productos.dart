import 'package:flutter/material.dart';
import 'package:yavi/conf/productos_provider.dart';
import 'package:yavi/models/producto.dart';
import 'package:yavi/pages/productos/add_producto.dart';
import 'package:yavi/widgets/producto_view.dart';

class ProductosPage extends StatelessWidget {
  ProductoProvider productoProvider = ProductoProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: productoProvider.getAll(),
          builder: (contex, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  Producto producto = Producto.fromMap(snapshot.data[index]);
                  return productoView(producto);
                }, childCount: snapshot.data.length))
              ],
            );

            // return SliverList(delegate: SliverAppBar(),);
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddProducto())),
      ),
    );
  }
}
