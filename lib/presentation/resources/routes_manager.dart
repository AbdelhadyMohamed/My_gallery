import 'package:flutter/material.dart';
import 'package:gallery_task/presentation/log_in/login_view.dart';

import '../gallery/gallery_view.dart';

class Routes {
  static const String loginRoute = "/login";
  static const String galleryRoute = "/gallery";
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LogInView(),
        );
      case Routes.galleryRoute:
        return MaterialPageRoute(
          builder: (context) => const GalleryView(),
        );
      default:
        return getUndefinedRoute();
    }
  }

  static Route getUndefinedRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text("undefined")),
          body: const Center(child: Text("undefined route")),
        );
      },
    );
  }
}
