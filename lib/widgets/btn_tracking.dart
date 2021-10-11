part of 'widgets.dart';

class BtnTracking extends StatelessWidget {
  const BtnTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocMap = BlocProvider.of<MapBloc>(context);

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
                blocMap.state.startTracking
                    ? Icons.directions_run_outlined
                    : Icons.accessibility_new_outlined,
                color: Colors.black,
              ),
              onPressed: () => blocMap.add(StartTracking()),
            ),
          ),
        );
      },
    );
  }
}
