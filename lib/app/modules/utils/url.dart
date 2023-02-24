class ApiEndPoint {
  static final String baseUrl = 'http://localhost/newsapp/';
  static _AuthEndPoint authEndPoint = _AuthEndPoint();
}

class _AuthEndPoint {
  final String registerEmail = '/register.php';
  final String loginEmail = '/login.php';
}
