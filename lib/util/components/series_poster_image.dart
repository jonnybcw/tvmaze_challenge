import 'package:flutter/material.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/modules/series_details/series_details_screen.dart';

class SeriesPosterImage extends StatelessWidget {
  const SeriesPosterImage({
    Key? key,
    required this.seriesDetails,
    this.onLongPress,
  }) : super(key: key);

  final SeriesDetails seriesDetails;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    String? image = seriesDetails.image?.medium;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SeriesDetailsScreen(
            seriesDetails: seriesDetails,
          ),
        ));
      },
      onLongPress: onLongPress,
      child: Stack(
        children: [
          if (image != null)
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
          if (image != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(8),
                child: Text(
                  seriesDetails.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          if (image == null)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  seriesDetails.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
