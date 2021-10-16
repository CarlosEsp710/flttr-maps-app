part of 'custom.dart';

class MarkerStartPainter extends CustomPainter {
  final int min;

  MarkerStartPainter(this.min);

  @override
  void paint(Canvas canvas, Size size) {
    const double radiusBlack = 20;
    const double radiusWhite = 7;

    Paint paint = Paint()..color = Colors.black;

    // Círculo negro
    canvas.drawCircle(
      Offset(radiusBlack, size.height - radiusBlack),
      radiusBlack,
      paint,
    );

    // Círculo blanco
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(radiusBlack, size.height - radiusBlack),
      radiusWhite,
      paint,
    );

    // Sombra
    final Path path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // Caja blanca
    final whiteBox = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(whiteBox, paint);
    // Caja negra
    paint.color = Colors.black;
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, paint);

    // Minutos
    TextSpan textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: '$min',
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 70, minWidth: 70);

    textPainter.paint(canvas, const Offset(40, 35));

    textSpan = const TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      text: 'Min.',
    );

    // Ubicación
    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 70, minWidth: 70);

    textPainter.paint(canvas, const Offset(40, 67));

    textSpan = const TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      text: 'Mi ubicación',
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: size.width - 130);

    textPainter.paint(canvas, const Offset(150, 50));
  }

  @override
  bool shouldRepaint(MarkerStartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerStartPainter oldDelegate) => false;
}
