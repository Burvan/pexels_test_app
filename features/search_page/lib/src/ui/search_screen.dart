import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:search_page/src/bloc/search_bloc.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (_) => SearchBloc(
        getTrendingPhotosUseCase: appLocator.get<GetTrendingPhotosUseCase>(),
      ),
      child: const _SearchScreen(),
    );
  }
}

class _SearchScreen extends StatelessWidget {
  const _SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CustomSearchField(
                      controller: searchController,
                      onSubmitted: (String query) {
                        context.read<SearchBloc>().add(
                              SearchPhotosEvent(query: query),
                            );
                      },
                      onPressed: () {
                        final query = searchController.text;

                        context.read<SearchBloc>().add(
                              SearchPhotosEvent(query: query),
                            );
                      },
                      focusNode: searchFocusNode,
                    ),
                    Expanded(
                      child: state.isLoading && state.photos.isEmpty
                          ? const SizedBox()
                          : (state.photos.isEmpty &&
                                  state.query?.isNotEmpty == true)
                              ? Center(
                                  child: Text(
                                    AppConstants.noResultsFound,
                                    style: AppTextTheme.font16TurquoiseBold,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.padding10,
                                  ),
                                  child: PhotoGrid(
                                    photos: state.photos,
                                    isLoading: state.isLoading,
                                    isEndOfList: state.isEndOfList,
                                    onLoadMore: () {
                                      context.read<SearchBloc>().add(
                                            SearchPhotosEvent(
                                              query: state.query ?? '',
                                            ),
                                          );
                                    },
                                    onPhotoTap: (Photo photo) {
                                      searchFocusNode.unfocus();
                                      context.navigateTo(
                                        DetailedPhotoRoute(photo: photo),
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
