import 'package:contadorwear/view/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  void initState(){
    listenToDataFromFirebase();
    super.initState();
  }

  void listenToDataFromFirebase() {
    databaseReference.child('mensajes').child('notificacion').onChildAdded.listen((event) {
      DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      dynamic data = snapshot.value;
      mostrarNotificacion('NotifyADNG', data);
      if (data is Map<dynamic, dynamic>) {
        String newMessage = data['descripcion'];
        mostrarNotificacion('NotifyADNG', newMessage);
      }
    }
  }, onError: (error) {
    mostrarNotificacion('NotifyADNG','Error al escuchar datos desde Firebase: $error');
  });
  }
  
  void writeToDatabase(String text) {
    databaseReference.child('mensajes').child('notificacion').set({
      'descripcion': text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo_1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.7), // Ajusta la opacidad aquí (0.0 a 1.0)
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '¡NotifyADNG!',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 2, // Altura de la línea
                        width: 100, // Ancho de la línea
                        color: Colors.teal, // Color de la línea
                      ),
                      const SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.message,
                                size: 10,
                                color: Colors.grey), // Icono de mensaje
                            SizedBox(width: 5),
                            Text(
                              'Mensaje:',
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]),
                      const SizedBox(height: 4),
                      TextField(
			style: TextStyle(fontSize: 12.0),
                        controller: _textEditingController,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: 'Escribe tu mensaje aquí',
                          contentPadding: const EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0,
                              left: 10.0,
                              right:
                                  10.0), // Aplica padding solo en la parte inferior
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Ajusta el radio para hacer los bordes redondeados
                            borderSide: const BorderSide(
                                color: Colors.teal), // Color del borde
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Ajusta el radio para hacer los bordes redondeados
                            borderSide: const BorderSide(
                                color: Colors
                                    .grey), // Color del borde cuando el TextField no está enfocado
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Ajusta el radio para hacer los bordes redondeados
                            borderSide: const BorderSide(
                                color: Colors
                                    .teal), // Color del borde cuando el TextField está enfocado
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      OutlinedButton(
                        onPressed: () {
                          writeToDatabase(_textEditingController.text);
                          _textEditingController.clear();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.teal),
                          /*padding:
                              const EdgeInsets.symmetric(horizontal: 150.0),*/
                        ),
                        child: const Text(
                          'ENVIAR',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ])))
      ])),
    );
  }
}
