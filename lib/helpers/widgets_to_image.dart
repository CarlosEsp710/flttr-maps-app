part of 'helpers.dart';

Future<BitmapDescriptor> getMarkerStart(int duration) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  final min = (duration / 60).floor();

  final markerStart = MarkerStartPainter(min);

  markerStart.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getMarkerDestination(
    String destination, double distance) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  final markerStart = MarkerDestinationPainter(destination, distance);

  markerStart.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
