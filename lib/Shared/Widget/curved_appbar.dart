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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      height: 200, // Height of the curved AppBar
      child: Stack(
        children: [
          // Draw the custom curve
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 280),
            painter: _AppBarCurvePainter(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                  if (trailingIcon != null)
                    IconButton(
                      icon: Icon(trailingIcon, color: Colors.white),
                      onPressed: onTrailingIconPressed,
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
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
