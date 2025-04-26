import 'package:flutter/material.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/register_page.dart';
import '../presentation/pages/upload_page.dart';
import '../presentation/pages/list_files_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const upload = '/upload';
  static const files = '/files';

  static final routes = <String, WidgetBuilder>{
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    upload: (_) => const UploadPage(),
    files: (_) => const ListFilesPage(),
  };
}