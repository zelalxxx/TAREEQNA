import 'package:flutter/material.dart';
import '../theme.dart';

enum ToastType { success, error, info }

void showToast(BuildContext context, String message, {ToastType type = ToastType.info}) {
  late Color bg; late IconData icon;
  switch (type) {
    case ToastType.success: bg = Colors.green.shade600; icon = Icons.check_circle; break;
    case ToastType.error:   bg = Colors.red.shade600;   icon = Icons.error_outline; break;
    case ToastType.info:    bg = TColors.blue;          icon = Icons.info_outline; break;
  }
  final bar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(12),
    duration: const Duration(seconds: 3),
    backgroundColor: bg,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    content: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(child: Text(message)),
      ],
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(bar);
}
