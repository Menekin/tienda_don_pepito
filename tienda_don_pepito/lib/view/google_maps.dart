import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tienda_don_pepito/model/store.dart';

class GoogleMapsWidget extends StatelessWidget {
  final Store tienda;
  GoogleMapsWidget(this.tienda);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps'),
          backgroundColor: Colors.redAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: GoogleMapsView(tienda),
      ),
    );
  }
}

class GoogleMapsView extends StatefulWidget {
  final Store tienda;
  GoogleMapsView(this.tienda);

  @override
  State<GoogleMapsView> createState() => GoogleMapsViewState();
}

class GoogleMapsViewState extends State<GoogleMapsView> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final CameraPosition _mainCamera = CameraPosition(
      target: LatLng(widget.tienda.latitud, widget.tienda.longitud),
      zoom: 18,
    );
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _mainCamera,
        markers: {
          Marker(
              markerId: MarkerId(widget.tienda.id),
              position: LatLng(widget.tienda.latitud, widget.tienda.longitud),
              infoWindow: InfoWindow(title: widget.tienda.nombre)),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {}
}
