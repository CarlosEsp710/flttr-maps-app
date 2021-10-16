part of 'custom.dart';

class MarkerDestinationPainter extends CustomPainter {
  final String destination;
  final double distance;

  MarkerDestinationPainter(this.destination, this.distance);

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
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // Caja blanca
    final whiteBox = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(whiteBox, paint);
    // Caja negra
    paint.color = Colors.black;
    const blackBox = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(blackBox, paint);

    // Km
    double km = distance / 1000;
    km = (km * 100).floorToDouble();
    km = km / 100;

    TextSpan textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      text: '$km',
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 70, minWidth: 70);

    textPainter.paint(canvas, const Offset(0, 35));

    textSpan = const TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      text: 'Km',
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 70);

    textPainter.paint(canvas, const Offset(25, 67));

    // Ubicación
    textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      text: destination,
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...',
    )..layout(maxWidth: size.width - 88);

    textPainter.paint(canvas, const Offset(80, 35));
  }

  @override
  bool shouldRepaint(MarkerDestinationPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerDestinationPainter oldDelegate) => false;
}
