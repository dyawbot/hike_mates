import 'package:mapbox_gl/mapbox_gl.dart';

mixin MarkerMixin {
  // Function to add markers
  Future<void> addMarkers(List<Map<String, dynamic>> data,
      MapboxMapController? mapController) async {
    if (mapController != null) {
      if (mapController.symbols.isNotEmpty) {
        await mapController.clearSymbols();
      }
      for (var entry in data) {
        var name = entry["name"];
        var location = entry["locations"];

        if (location is LatLng) {
          if (!mapController.symbols
              .any((symbol) => symbol.options.geometry == location)) {
            await mapController.addSymbol(
              SymbolOptions(
                geometry: location,
                iconImage: "assets/marker.png",
                iconSize: 1,
                textOpacity: 0.5,
                textAnchor: "bottom",
                textHaloColor: "#99FFFF",
                textHaloWidth: 10.0,
                textHaloBlur: 2,
                textColor: "#F00000",
                textTransform: "uppercase",
                textField: name,
              ),
            );
          }
        }
      }
    }
  }

  // Function to add radius circle
  Future<void> addRadiusCircle(LatLng location, double radiusInMeters,
      MapboxMapController? mapController) async {
    await mapController!.addCircle(
      CircleOptions(
        geometry: location,
        circleRadius: _calculateCircleRadius(radiusInMeters, mapController),
        circleColor: '#FF0000',
        circleOpacity: 0.3,
      ),
    );
  }

  // Adjust circle size based on zoom level
  double _calculateCircleRadius(
      double radiusInMeters, MapboxMapController? mapController) {
    double zoomLevel = mapController!.cameraPosition!.zoom;
    double radius =
        radiusInMeters / (1000 / (zoomLevel + 2)); // Adjust this formula
    return radius;
  }
}
