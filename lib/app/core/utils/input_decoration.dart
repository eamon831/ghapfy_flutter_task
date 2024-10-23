import '/app/core/exporter.dart';

final primaryInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.green,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  border: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.all(10),
  hintStyle: const TextStyle(
    color: Colors.grey,
  ),
  labelStyle: const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  errorStyle: const TextStyle(
    color: Colors.red,
  ),
  focusColor: Colors.green,
  hoverColor: Colors.green,
);
