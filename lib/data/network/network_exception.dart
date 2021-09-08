class NetworkException implements Exception {
  NetworkException();

  String toString() {
    return "No cuenta con una conexion de internet. Revise su conexión e intente nuevamente.";
  }
}
