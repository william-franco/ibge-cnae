class CnaeException implements Exception {
  final String message;

  const CnaeException(this.message);

  @override
  String toString() => message;
}