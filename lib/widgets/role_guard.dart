
import 'package:flutter/material.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class RoleGuard extends StatelessWidget {
  const RoleGuard({
    super.key,
    required this.role,
    required this.allowed,
    required this.child,
  });

  final String role;
  final List<String> allowed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return allowed.contains(role)
        ? child
        : const SizedBox.shrink();
  }
}

