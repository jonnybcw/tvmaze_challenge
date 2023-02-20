import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tvmaze_challenge/data/models/person.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/modules/person_details/bloc/person_details_bloc.dart';
import 'package:tvmaze_challenge/util/components/empty_component.dart';
import 'package:tvmaze_challenge/util/components/error_component.dart';
import 'package:tvmaze_challenge/util/components/series_poster_image.dart';

class PersonDetailsScreen extends StatefulWidget {
  const PersonDetailsScreen({
    required this.person,
    Key? key,
  }) : super(key: key);

  final Person person;

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  late PersonDetailsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PersonDetailsBloc(
      person: widget.person,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.person.name),
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, PersonDetailsState state) {
    if (state is PersonDetailsLoadFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is PersonDetailsLoadSuccess) {
      String? image = state.person.image?.original;
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (image != null)
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: image,
                fit: BoxFit.fitWidth,
                width: 120,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Text(
                'Known For',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (state.series.isEmpty)
              const SizedBox(
                height: 300,
                child: EmptyComponent(),
              ),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  SeriesDetails seriesDetails = state.series[index];
                  return SeriesPosterImage(
                    seriesDetails: seriesDetails,
                  );
                },
                itemCount: state.series.length,
              ),
            )
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
