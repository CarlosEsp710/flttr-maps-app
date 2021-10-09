import 'package:flutter/material.dart';

import 'package:maps/screens/loading_page.dart';
import 'package:maps/screens/access_gps_page.dart';
import 'package:maps/screens/map_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'access_gps': (_) => const AccessGPSPage(),
  'map': (_) => const MapPage()
};
