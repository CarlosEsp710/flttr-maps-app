part of 'widgets.dart';

class BtnPolylines extends StatelessWidget {
  const BtnPolylines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocMap = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.black),
          onPressed: () => blocMap.add(DrawRoute()),
        ),
      ),
    );
  }
}
