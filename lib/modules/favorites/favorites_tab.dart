import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/modules/favorites/bloc/favorites_bloc.dart';
import 'package:tvmaze_challenge/util/components/empty_component.dart';
import 'package:tvmaze_challenge/util/components/error_component.dart';
import 'package:tvmaze_challenge/util/components/series_poster_image.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  late FavoritesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = FavoritesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Favorites'),
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, FavoritesState state) {
    if (state is FavoritesLoadFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is FavoritesLoadSuccess) {
      if (state.series.isEmpty) {
        return const EmptyComponent();
      }
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.7,
        ),
        itemCount: state.series.length,
        itemBuilder: (context, index) {
          SeriesDetails seriesDetails = state.series[index];
          return SeriesPosterImage(
            seriesDetails: seriesDetails,
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: InkWell(
                          onTap: () {
                            bloc.add(
                                DeleteSeriesTapped(seriesId: seriesDetails.id));
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Delete series from favorites list'),
                          ),
                        ),
                      ));
            },
          );
        },
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
