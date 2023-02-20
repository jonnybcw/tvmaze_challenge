import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tvmaze_challenge/data/models/series_episode.dart';

class EpisodeDetailsDialog extends StatelessWidget {
  const EpisodeDetailsDialog({
    required this.episode,
    Key? key,
  }) : super(key: key);

  final SeriesEpisode episode;

  @override
  Widget build(BuildContext context) {
    String? summary = episode.summary;
    String? image = episode.image?.medium;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 520,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    episode.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child:
                  Text('Season ${episode.season} - Episode ${episode.number}'),
            ),
            if (summary != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (image != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                        child: Html(
                          data: summary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
