part of 'widgets.dart';

class BtnLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final myLocationBloc = BlocProvider.of<MyLocationBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
            icon: Icon(
              Icons.my_location,
              color: Colors.black87,
            ),
            onPressed: () {
              final destination = myLocationBloc.state.location;
              mapBloc.moveCamera(destination);
            }),
      ),
    );
  }
}
