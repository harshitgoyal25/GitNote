import 'package:flutter/material.dart';

void showAppMessage(BuildContext context, String message, {bool isError = false}) {
  final color = isError ? const Color.fromARGB(255, 216, 216, 255) : const Color.fromARGB(255, 105, 157, 240);
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (ctx) => Positioned(
      bottom: 70,
      left: MediaQuery.of(ctx).size.width * 0.1,
      right: MediaQuery.of(ctx).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.7), width: 1),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.25),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 2), () => entry.remove());
}
