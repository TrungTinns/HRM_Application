import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hrm_application/presentation/bindings/auth/auth_binding.dart';
import 'package:hrm_application/presentation/views/auth/auth_view.dart';
import 'package:hrm_application/presentation/views/home/home.dart';

class AppRoutes {
  static const String auth = "/auth";
  static const String home = "/home";

  static List<GetPage> routers = [
    GetPage(name: auth, page: () => AuthView(), binding: AuthBinding()),
    GetPage(name: home, page: () => Home()),
    // Add more routes here as needed.
  ];
}
