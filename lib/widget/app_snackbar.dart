import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        SnackType type = SnackType.info,
      }) {
    final overlay = Overlay.of(context);

    late Color bgColor;
    late IconData icon;

    switch (type) {
      case SnackType.success:
        bgColor = Colors.purple.withAlpha(90);
        icon = Icons.check_circle;
        break;
      case SnackType.error:
        bgColor = Colors.red;
        icon = Icons.error;
        break;
      case SnackType.warning:
        bgColor = Colors.orange;
        icon = Icons.warning;
        break;
      case SnackType.info:
        bgColor = Colors.green;
        icon = Icons.info;
        break;
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 60,
        left: 20,
        right: 20,
        child: _AnimatedSnackBar(
          message: message,
          bgColor: bgColor,
          icon: icon,
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3)).then((_) {
      overlayEntry.remove();
    });
  }
}

enum SnackType { success, error, warning, info }

class _AnimatedSnackBar extends StatefulWidget {
  final String message;
  final Color bgColor;
  final IconData icon;

  const _AnimatedSnackBar({
    required this.message,
    required this.bgColor,
    required this.icon,
  });

  @override
  State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.bgColor,
                widget.bgColor.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: widget.bgColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
