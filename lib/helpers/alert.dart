part of 'helpers.dart';

void alert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      title: Text('Espere por favor'),
      content: Text('Calculando ruta'),
    ),
  );
}
