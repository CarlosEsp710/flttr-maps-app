part of 'widgets.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocMap = BlocProvider.of<MapBloc>(context);
    final blocLocation = BlocProvider.of<LocationBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location_outlined, color: Colors.black),
          onPressed: () {
            final location = blocLocation.state.location;

            blocMap.moveCamera(location!);
          },
        ),
      ),
    );
  }
}
