import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class RouteMapPainter extends CustomPainter {
  const RouteMapPainter({required this.animationValue});

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    // Coordinate scale factors relative to original 760x300 canvas
    final scaleX = size.width / 760.0;
    final scaleY = size.height / 300.0;

    Offset pt(double x, double y) => Offset(x * scaleX, y * scaleY);

    // 1. Inactive Background Trunk Path
    final trunkPaint = Paint()
      ..color = AppColors.onSurface.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0 * scaleX
      ..strokeCap = StrokeCap.round;

    final trunkPath = Path()
      ..moveTo(60 * scaleX, 230 * scaleY)
      ..cubicTo(
        180 * scaleX,
        220 * scaleY,
        240 * scaleX,
        180 * scaleY,
        340 * scaleX,
        150 * scaleY,
      )
      ..cubicTo(
        440 * scaleX,
        120 * scaleY,
        520 * scaleX,
        80 * scaleY,
        680 * scaleX,
        70 * scaleY,
      );

    canvas.drawPath(trunkPath, trunkPaint);

    // 2. Abu Dhabi <-> Dubai Active Line (Amber)
    final dxbToAuhPaint = Paint()
      ..color = AppColors.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5 * scaleX
      ..strokeCap = StrokeCap.round;

    final dxbToAuhPath = Path()
      ..moveTo(60 * scaleX, 230 * scaleY)
      ..cubicTo(
        180 * scaleX,
        220 * scaleY,
        240 * scaleX,
        180 * scaleY,
        340 * scaleX,
        150 * scaleY,
      );

    canvas.drawPath(dxbToAuhPath, dxbToAuhPaint);

    // 3. Dubai <-> Sharjah / RAK Active Line (Signal Green)
    final dxbToRakPaint = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5 * scaleX
      ..strokeCap = StrokeCap.round;

    final dxbToRakPath = Path()
      ..moveTo(340 * scaleX, 150 * scaleY)
      ..cubicTo(
        440 * scaleX,
        120 * scaleY,
        520 * scaleX,
        80 * scaleY,
        680 * scaleX,
        70 * scaleY,
      );

    canvas.drawPath(dxbToRakPath, dxbToRakPaint);

    // Draw Nodes

    // Node 1: Abu Dhabi (Mussafah) (60, 230)
    final node1Center = pt(60, 230);
    _drawNode(
      canvas: canvas,
      center: node1Center,
      outerRadius: 14 * scaleX,
      innerRadius: 5 * scaleX,
      color: AppColors.primaryContainer,
      title: 'ABU DHABI (Mussafah)',
      subtitle: 'ICAD I & II Hub',
      titleOffset: Offset(20 * scaleX, -8 * scaleY),
      subtitleOffset: Offset(20 * scaleX, 8 * scaleY),
      scale: scaleX,
    );

    // Node 2: Dubai Central Dispatch (340, 150) - Flagship Pulsing Hub
    final node2Center = pt(340, 150);

    // Pulse wave animation around Dubai Hub
    final pulseRadius = (16 + (14 * animationValue)) * scaleX;
    final pulseAlpha = (0.5 * (1.0 - animationValue)).clamp(0.0, 1.0);
    final pulsePaint = Paint()
      ..color = AppColors.primaryContainer.withValues(alpha: pulseAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0 * scaleX;
    canvas.drawCircle(node2Center, pulseRadius, pulsePaint);

    _drawNode(
      canvas: canvas,
      center: node2Center,
      outerRadius: 18 * scaleX,
      innerRadius: 8 * scaleX,
      color: AppColors.primaryContainer,
      title: 'DUBAI CENTRAL DISPATCH',
      subtitle: 'JAFZA • DIP • Al Quoz 1-4',
      titleOffset: Offset(-180 * scaleX, -34 * scaleY),
      subtitleOffset: Offset(-165 * scaleX, -18 * scaleY),
      scale: scaleX,
      isFlagship: true,
    );

    // Node 3: Sharjah & Ajman (500, 105)
    final node3Center = pt(500, 105);
    _drawNode(
      canvas: canvas,
      center: node3Center,
      outerRadius: 11 * scaleX,
      innerRadius: 4 * scaleX,
      color: AppColors.secondary,
      title: 'SHARJAH & AJMAN',
      subtitle: 'Industrial Areas 1-18',
      titleOffset: Offset( scaleX, 10* scaleY),
      subtitleOffset: Offset( scaleX, 25* scaleY),
      scale: scaleX,
    );

    // Node 4: Ras Al Khaimah (680, 70)
    final node4Center = pt(680, 70);
    _drawNode(
      canvas: canvas,
      center: node4Center,
      outerRadius: 13 * scaleX,
      innerRadius: 5 * scaleX,
      color: AppColors.tertiary,
      title: 'RAS AL KHAIMAH',
      subtitle: 'Al Hamra / Port',
      titleOffset: Offset(-90 * scaleX, -40* scaleY),
      subtitleOffset: Offset(-90 * scaleX, -20 * scaleY),
      scale: scaleX,
    );
  }

  void _drawNode({
    required Canvas canvas,
    required Offset center,
    required double outerRadius,
    required double innerRadius,
    required Color color,
    required String title,
    required String subtitle,
    required Offset titleOffset,
    required Offset subtitleOffset,
    required double scale,
    bool isFlagship = false,
  }) {
    // Background Disk
    final diskPaint = Paint()
      ..color = AppColors.surfaceContainer
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, outerRadius, diskPaint);

    // Border
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = isFlagship ? 2.5 * scale : 2.0 * scale;
    canvas.drawCircle(center, outerRadius, borderPaint);

    // Center Core
    final corePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, corePaint);

    // Title Text
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          color: isFlagship ? AppColors.primary : AppColors.onSurface,
          fontSize: (isFlagship ? 12.0 : 10.5) * scale.clamp(0.8, 1.2),
          fontWeight: isFlagship ? FontWeight.w800 : FontWeight.w700,
          fontFamily: 'Manrope',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, center + titleOffset);

    // Subtitle Text
    final subPainter = TextPainter(
      text: TextSpan(
        text: subtitle,
        style: TextStyle(
          color: AppColors.onSurfaceVariant,
          fontSize: 9.0 * scale.clamp(0.8, 1.2),
          fontFamily: 'Manrope',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    subPainter.paint(canvas, center + subtitleOffset);
  }

  @override
  bool shouldRepaint(covariant RouteMapPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
