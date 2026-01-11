import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/page_transitions.dart';
import '../screens/mode_selection_screen.dart';

class ModeSwitcherButton extends StatelessWidget {
  final bool isCompact;

  const ModeSwitcherButton({
    super.key,
    this.isCompact = false,
  });

  void _switchMode(BuildContext context) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pushReplacement(
      PageTransitions.fadeTransition(const ModeSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      // Icon button for AppBar
      return IconButton(
        icon: const Icon(Icons.swap_horiz),
        onPressed: () => _switchMode(context),
        tooltip: 'Switch Mode',
      );
    }

    // Button for drawer/menu
    return ListTile(
      leading: const Icon(Icons.swap_horiz),
      title: const Text('Switch Mode'),
      onTap: () => _switchMode(context),
    );
  }
}

/// Shows a dialog to switch modes
class ModeSwitcherDialog extends StatelessWidget {
  const ModeSwitcherDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Switch Mode?'),
      content: const Text(
        'Do you want to switch to a different mode?\n\nYour current progress will be saved.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pushReplacement(
              PageTransitions.fadeTransition(const ModeSelectionScreen()),
            );
          },
          child: const Text('Switch Mode'),
        ),
      ],
    );
  }
}
