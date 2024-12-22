import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget {
  final String title;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;

  const CurvedAppBar({
    super.key,
    required this.title,
    this.trailingIcon,
    this.onTrailingIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Access the theme and its properties
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Access colors
    final textTheme = theme.textTheme; // Access text styles

    return SizedBox(
      height: 150, // Height of the curved AppBar
      child: Stack(
        children: [
          // Draw the custom curve
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 280),
            painter: _AppBarCurvePainter(
              color: colorScheme.primary, // Use primary color
            ),
          ),
          SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50),
                    Text(
                      title,
                      style:
                          textTheme.titleLarge, // Use titleLarge from the theme
                    ),
                    if (trailingIcon != null)
                      IconButton(
                        icon: Icon(trailingIcon, color: Colors.white),
                        onPressed: onTrailingIconPressed,
                      ),
                  ],
                )),
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
