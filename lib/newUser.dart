import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class newUser extends StatefulWidget {
  const newUser({super.key});

  @override
  State<newUser> createState() => _newUserState();
}



class _newUserState extends State<newUser> {
  CollectionReference clientes = FirebaseFirestore.instance.collection('clientes');
  TextEditingController _nombreCliente = TextEditingController();
  TextEditingController _apellido = TextEditingController();
  TextEditingController _dui = TextEditingController();
  TextEditingController _usuario = TextEditingController();
  bool estado=false;
  late bool sexo=false;
  
  _guardar (){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El cliente fue eliminado correctamente')));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Registro"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 35),
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
                    IconButton(icon:Icon(Icons.boy) ,onPressed: (){estado=true; sexo=true;setState(() {
                      
                    });},),
                    IconButton(icon:Icon(Icons.girl_rounded) ,onPressed: (){ estado =true;sexo=false; setState(() {
                      
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: ()async {
           final String nombre = _nombreCliente.text;
           final String apellido= _apellido.text;
           final String dui = _dui.text;
           final String usuario = _usuario.text;
                    
                    if (estado ==true && nombre != '' && apellido != '' && dui != '' && usuario!='') {
                      estado=false;
                      await clientes
                          .add({"apellido": apellido, "cedula": dui,
                             "nombre":nombre,"usuario":usuario,'sexo':sexo
                          }
                          
                          );

                      _nombreCliente.text = '';
                      _apellido.text = '';
                       _dui.text = '';
                         _usuario.text = '';
                      Navigator.of(context).pop();
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ingrese todos los datos")));
        }
        }
      ),
    );
  }
}
