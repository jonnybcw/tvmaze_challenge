import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tvmaze_challenge/data/models/person.dart';
import 'package:tvmaze_challenge/data/models/search_type_enum.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/modules/person_details/person_details_screen.dart';
import 'package:tvmaze_challenge/modules/search/bloc/search_bloc.dart';
import 'package:tvmaze_challenge/util/components/empty_component.dart';
import 'package:tvmaze_challenge/util/components/error_component.dart';
import 'package:tvmaze_challenge/util/components/series_poster_image.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late SearchBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SearchBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: SizedBox(
                height: 48,
                child: TextField(
                  controller: state.searchController,
                  onChanged: (text) {
                    bloc.add(QueryChanged());
                  },
                  onSubmitted: (text) {
                    bloc.add(QueryChanged());
                  },
                  autofocus: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    bloc.add(ClearQueryTapped());
                  },
                  icon: const Icon(Icons.close_rounded),
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 48),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      const Text('Search for'),
                      const SizedBox(width: 24),
                      DropdownButton<SearchType>(
                        items: SearchType.values
                            .map(
                              (e) => DropdownMenuItem<SearchType>(
                                value: e,
                                child: Text(
                                  e.name.substring(0, 1).toUpperCase() +
                                      e.name.substring(1).toLowerCase(),
                                ),
                              ),
                            )
                            .toList(),
                        value: state.searchType,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(SearchTypeChanged(searchType: value));
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        dropdownColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, SearchState state) {
    if (state is SearchInitial) {
      return const SizedBox();
    } else if (state is SearchLoadFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is SearchLoadSuccess) {
      if (state.searchType == SearchType.series) {
        if (state.seriesResults.isEmpty) {
          return const EmptyComponent();
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            SeriesDetails seriesDetails = state.seriesResults[index].show;
            return SeriesPosterImage(
              seriesDetails: seriesDetails,
            );
          },
          itemCount: state.seriesResults.length,
        );
      } else {
        if (state.peopleResults.isEmpty) {
          return const EmptyComponent();
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            Person person = state.peopleResults[index].person;
            String? image = person.image?.medium;
            return SizedBox(
              height: 80,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PersonDetailsScreen(person: person),
                  ));
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
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              person.name,
                              style: Theme.of(context).textTheme.titleMedium,
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
          itemCount: state.peopleResults.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        );
      }
    }
    return const Center(child: CircularProgressIndicator());
  }
}
