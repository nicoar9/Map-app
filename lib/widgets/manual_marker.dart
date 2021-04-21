part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) =>
          state.manualSelection ? _BuildManualMarker() : SizedBox(),
    );
  }
}

class _BuildManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 20,
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                searchBloc.add(OnDisabledManualMarker());
              },
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: Icon(
              Icons.location_on,
              size: 50,
            ),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 40,
          child: MaterialButton(
            minWidth: width - 120,
            child: Text(
              'Confirm Destination',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            color: Colors.black87,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
