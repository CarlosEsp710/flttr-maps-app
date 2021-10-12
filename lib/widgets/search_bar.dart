part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manual) return Container();

        return FadeInDown(
          duration: const Duration(milliseconds: 300),
          child: buildSeachBar(context),
        );
      },
    );
  }

  Widget buildSeachBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: SearchDestination(),
            );

            _searchResult(context, result!);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: const Text(
              '¿A dónde quieres ir?',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _searchResult(BuildContext context, SearchResult result) {
    if (result.canel) return;
    if (result.manual!) {
      BlocProvider.of<SearchBloc>(context).add(ActivatePinManual());
      return;
    }
  }
}
