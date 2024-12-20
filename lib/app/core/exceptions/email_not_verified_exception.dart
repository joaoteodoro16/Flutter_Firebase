class EmailNotVerifiedException implements Exception {
final String message;
  EmailNotVerifiedException({
    required this.message,
  });
}
