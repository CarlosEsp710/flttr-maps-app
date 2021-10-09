import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;

import 'package:maps/helpers/helpers.dart';
import 'package:maps/screens/access_gps_page.dart';
import 'package:maps/screens/map_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
          context,
          navigateMapFadeIn(context, const MapPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGPSLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }
        },
      ),
    );
  }

  Future checkGPSLocation(BuildContext context) async {
    final permission = await Permission.location.isGranted;
    final gpsActive = await Geolocator.isLocationServiceEnabled();

    if (permission && gpsActive) {
      Navigator.pushReplacement(
        context,
        navigateMapFadeIn(context, const MapPage()),
      );
      return '';
    } else if (!permission) {
      Navigator.pushReplacement(
        context,
        navigateMapFadeIn(context, const AccessGPSPage()),
      );
      return 'Es necesario el permiso de GPS';
    } else {
      return 'Active el GPS';
    }
  }
}
