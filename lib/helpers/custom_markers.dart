part of 'helpers.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(devicePixelRatio: 2.5),
    'assets/custom-pin.png',
  );
}
