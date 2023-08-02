
import 'package:atm_tracker/views/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static List<GetPage> get pages => [
        GetPage(name: SplashScreen.route, page: () => SplashScreen())
      ];
}
