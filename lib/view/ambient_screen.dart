import 'package:flutter/material.dart';

class AmbientWatchFace extends StatefulWidget {
  @override
  _AmbientWatchFaceState createState() => _AmbientWatchFaceState();
}

class _AmbientWatchFaceState extends State<AmbientWatchFace> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  // Simula un proceso de carga por 5 segundos
  void _loadContent() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'NotifyADNG',
                    style: TextStyle(color: Colors.teal[300], fontSize: 30),
                  ),
                  const SizedBox(height: 15),
                  FlutterLogo(size: 60.0),
                ],
              ),
      ),
    );
  }
}
