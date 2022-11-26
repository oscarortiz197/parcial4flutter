import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class detalle extends StatefulWidget {
  final String idCliente;
  const detalle({super.key, required this.idCliente});

  @override
  State<detalle> createState() => _detalleState();
}

class _detalleState extends State<detalle> {
  //CollectionReference clientes = FirebaseFirestore.instance.collection('clientes').doc(widget.idCliente.toString()).get();
   late  var _snapshot=null;
    Map <String,dynamic> datos={};
    //CollectionReference clientes = FirebaseFirestore.instance.collection('clientes');
  TextEditingController _nombreCliente = TextEditingController();
  TextEditingController _apellido = TextEditingController();
  TextEditingController _dui = TextEditingController();
  TextEditingController _usuario = TextEditingController();
  
  late bool sexo;
  @override
  void initState() {
    _datosusuario();
    // TODO: implement initState
    //print(snapshot);
    super.initState();
  }

  Future<void> _datosusuario() async {
    _snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .doc(widget.idCliente)
        .get();
        datos=_snapshot.data();
        _nombreCliente.text=datos['nombre'].toString();
        _apellido.text=datos['apellido'].toString();
        _dui.text=datos['cedula'].toString();
        _usuario.text=datos['usuario'].toString();
        sexo=datos['sexo'];
    setState(() {});
  }

  Future<void> _actualizar()async{
    CollectionReference _clientes=FirebaseFirestore.instance.collection('clientes');

    final String nombre = _nombreCliente.text;
           final String apellido= _apellido.text;
           final String dui = _dui.text;
           final String usuario = _usuario.text;
                    
                    if ( nombre != '' && apellido != '' && dui != '' && usuario!='') {
                     
                      await _clientes
                          .doc(widget.idCliente).update({"apellido": apellido, "cedula": dui,
                             "nombre":nombre,"usuario":usuario,'sexo':sexo
                          }
                          
                          );
                          Navigator.of(context).pop();
                    }
  }

  @override
  Widget build(BuildContext context) {
    if (_snapshot != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detalle cliente"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            width: 350,
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextField( controller: _nombreCliente, decoration:const InputDecoration(label:Text("Nombre:")),),
                    SizedBox(height: 20,),
                    TextField(controller: _apellido, decoration:const InputDecoration(label: Text("Apellido:")),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(iconSize:45, icon:Icon(Icons.boy), color: sexo==true?Colors.green:Colors.white ,onPressed: (){ sexo=true;setState(() {
                          
                        });},),
                        IconButton(iconSize: 45, icon:Icon(Icons.girl_rounded),color: sexo==false?Colors.green :Colors.white, onPressed: (){sexo=false; setState(() {
                          
                        });},),
                      ],
                    ),
                    TextField(controller: _dui, decoration: const InputDecoration(label: Text("Dui:")),),
                    SizedBox(height: 20,),
                    TextField( controller: _usuario, decoration:const InputDecoration(label: Text("Usuario:")),),
                  ],
                ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){_actualizar();},child: Icon(Icons.save)),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detalle cliente"),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
