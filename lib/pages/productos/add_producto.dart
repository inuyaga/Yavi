import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yavi/conf/productos_provider.dart';
import 'package:yavi/models/producto.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddProducto extends StatefulWidget {
  const AddProducto({Key? key}) : super(key: key);

  @override
  _AddProductoState createState() => _AddProductoState();
}

class _AddProductoState extends State<AddProducto> {
  // Producto producto = Producto();
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final precioController = TextEditingController();
  final precioCostoController = TextEditingController();
  final descripcionController = TextEditingController();
  final imgController = TextEditingController();
  final codebarController = TextEditingController();
  late Widget _imageToShow;
  final ImagePicker _picker = ImagePicker();
  String imagenPath = "";
  ProductoProvider provProd = ProductoProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageToShow = const Image(image: AssetImage('no_photo.png'));
  }

  void updateImage(file) {
    setState(() {
      _imageToShow = Image.file(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar producto"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: codebarController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo requerido';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Codigo de Barra",
                              label: Text("Codigo de Barra")),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          String barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                        },
                        icon: const Icon(Icons.qr_code_2))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: nombreController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo requerido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Nombre", label: Text("Nombre")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: descripcionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo requerido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Descripcion", label: Text("Descripcion")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: precioController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo requerido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Precio", label: Text("Precio")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: precioCostoController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo requerido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Precio Compra",
                        label: Text("Precio Compra")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  child: _imageToShow,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton.icon(
                      icon: const Icon(Icons.photo),
                      onPressed: () async {
                        File? foto = await takePhoto();
                        if (foto != null) {
                          imgController.text = foto.path;
                          updateImage(foto);
                        }
                      },
                      label: const Text("Foto")),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          saveProducto();
                          nombreController.clear();
                          descripcionController.clear();
                          precioController.clear();
                          precioCostoController.clear();
                        }
                      },
                      child: const Text("Guardar")),
                ),
              ],
            )),
      ),
    );
  }

  saveProducto() async {
    Producto producto = Producto(
        codebar: codebarController.text,
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        precio: double.parse(precioController.text),
        precioCosto: double.parse(
          precioCostoController.text,
        ),
        img: imgController.text);

    ProductoProvider provProd = ProductoProvider();
    producto = await provProd.insert(producto);
  }

  Future<File?> takePhoto() async {
    File? file;
    // copy the file to a new path
    final Directory docDir = await getApplicationDocumentsDirectory();
    await _picker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        file = File('${docDir.path}${value.path.split("/").last}');
        value.saveTo(file!.path);
      }
    });
    return file;
  }
}
