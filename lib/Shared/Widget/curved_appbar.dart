import 'package:flutter/material.dart';
import '../../Notification/notification_screen.dart';

class CurvedAppBar extends StatelessWidget {
  final String title;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final bool showNotificationIndicator;

  const CurvedAppBar({
    super.key,
    required this.title,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.showNotificationIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 280),
            painter: _AppBarCurvePainter(
                color: Theme.of(context).colorScheme.primary),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 50),
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  if (trailingIcon != null)
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(trailingIcon, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ));
                          },
                        ),
                        if (showNotificationIndicator)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarCurvePainter extends CustomPainter {
  final Color color;

  _AppBarCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color // Use the color passed to the painter
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
