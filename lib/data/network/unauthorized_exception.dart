class UnauthorizedException implements Exception {
  UnauthorizedException();

  String toString() {
    return "Su sesión ha expirado. Por favor vuelva a loguearse.";
  }
}
