import 'package:flutter/material.dart';
import '../core/theme.dart';

class StateView extends StatelessWidget {
  final IconData icon;
  final String title, message;
  final String? action;
  final VoidCallback? onAction;
  final Color color;
  const StateView({super.key, required this.icon, required this.title, required this.message, this.action, this.onAction, this.color = AppColors.muted});

  factory StateView.empty({String message = 'Nothing here yet.'}) =>
      StateView(icon: Icons.inbox_outlined, title: 'Empty', message: message);
  factory StateView.error({String message = 'Something went wrong.', VoidCallback? onRetry}) => StateView(
      icon: Icons.error_outline, title: 'Error', message: message, action: 'Retry', onAction: onRetry, color: AppColors.error);
  factory StateView.offline({VoidCallback? onRetry}) => StateView(
      icon: Icons.wifi_off, title: 'You are offline', message: 'Check your connection.', action: 'Retry', onAction: onRetry);
  factory StateView.success({String message = 'Done.'}) =>
      StateView(icon: Icons.check_circle_outline, title: 'Success', message: message, color: AppColors.accent);
  factory StateView.loading() =>
      const StateView(icon: Icons.hourglass_empty, title: 'Loading', message: 'Please wait...');

  @override
  Widget build(BuildContext c) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 56, color: color),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted)),
            if (action != null) ...[const SizedBox(height: 16), OutlinedButton(onPressed: onAction, child: Text(action!))],
          ]),
        ),
      );
}
