import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/models/series_episode.dart';
import 'package:tvmaze_challenge/modules/episode_details/episode_details_dialog.dart';
import 'package:tvmaze_challenge/modules/series_details/bloc/series_details_bloc.dart';
import 'package:tvmaze_challenge/util/components/error_component.dart';

class SeriesDetailsScreen extends StatefulWidget {
  const SeriesDetailsScreen({
    required this.seriesDetails,
    Key? key,
  }) : super(key: key);

  final SeriesDetails seriesDetails;

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  late SeriesDetailsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SeriesDetailsBloc(
      seriesDetails: widget.seriesDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SeriesDetailsBloc, SeriesDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.seriesDetails.name),
              actions: state is SeriesDetailsLoadSuccess
                  ? [
                      IconButton(
                        onPressed: () {
                          bloc.add(FavoriteButtonTapped());
                        },
                        icon: Icon(state.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded),
                      )
                    ]
                  : [],
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, SeriesDetailsState state) {
    if (state is SeriesDetailsLoadFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is SeriesDetailsLoadSuccess) {
      String? image = state.seriesDetails.image?.medium;
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 12, top: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          image,
                          fit: BoxFit.fitWidth,
                          width: 120,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Html(
                      data: state.seriesDetails.summary ??
                          'No summary has been provided for this show yet',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (state.seriesDetails.scheduleText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Schedule: ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      TextSpan(
                        text: state.seriesDetails.scheduleText,
                      ),
                    ],
                  ),
                ),
              ),
            if (state.seriesDetails.genresText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Genres: ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      TextSpan(
                        text: state.seriesDetails.genresText,
                      ),
                    ],
                  ),
                ),
              ),
            if (state.seasons.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: Text(
                  'Seasons: ',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            SizedBox(
              height: 32,
              child: ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemCount: state.seasons.length,
                itemBuilder: (context, index) {
                  int season = state.seasons.elementAt(index);
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 8)
                        : (index == state.seasons.length - 1
                            ? const EdgeInsets.only(right: 8)
                            : EdgeInsets.zero),
                    child: Material(
                      color: state.currentSeason == season
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          bloc.add(SeasonTapped(season: season));
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Center(
                            child: Text(
                              season.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.episodes.length,
                  itemBuilder: (context, index) {
                    SeriesEpisode episode = state.episodes.elementAt(index);
                    String? image = episode.image?.medium;
                    return SizedBox(
                      height: image != null ? 70 : 36,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                EpisodeDetailsDialog(episode: episode),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          children: [
                            if (image != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      '${episode.number}. ${episode.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
