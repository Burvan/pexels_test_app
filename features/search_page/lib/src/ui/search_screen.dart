import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:search_page/src/bloc/search_bloc.dart';
import 'package:search_page/src/ui/widgets/search_request_tile.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (_) => SearchBloc(
        getTrendingPhotosUseCase: appLocator.get<GetTrendingPhotosUseCase>(),
        getSearchHistoryUseCase: appLocator.get<GetSearchHistoryUseCase>(),
        addRequestToHistoryUseCase:
            appLocator.get<AddRequestToHistoryUseCase>(),
        clearSearchHistoryUseCase: appLocator.get<ClearSearchHistoryUseCase>(),
      ),
      child: const _SearchScreen(),
    );
  }
}

class _SearchScreen extends StatefulWidget {
  const _SearchScreen({super.key});

  @override
  State<_SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_SearchScreen>
    with WidgetsBindingObserver {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isSearchFocused = false;
  late TabsRouter tabsRouter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    searchFocusNode.addListener(() {
      setState(() {
        isSearchFocused = searchFocusNode.hasFocus;
      });
    });

    tabsRouter = AutoTabsRouter.of(context);
    tabsRouter.addListener(_onTabChange);
  }

  void _onTabChange() {
    if (tabsRouter.activeIndex != 1) {
      searchFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchFocusNode.removeListener(() {});
    tabsRouter.removeListener(_onTabChange);
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bool isKeyboardVisible =
        WidgetsBinding.instance.window.viewInsets.bottom > 0;

    if (!isKeyboardVisible) {
      searchFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        final String query = searchController.text;

                        if (query.isNotEmpty) {
                          context.read<SearchBloc>().add(
                            SearchPhotosEvent(query: query),
                          );
                        }
                      },
                      onPressed: () {
                        final String query = searchController.text;

                        if (query.isNotEmpty) {
                          context.read<SearchBloc>().add(
                            SearchPhotosEvent(query: query),
                          );
                        }
                      },
                      focusNode: searchFocusNode,
                      onTap: () {
                        context.read<SearchBloc>().add(
                              LoadSearchHistoryEvent(),
                            );
                      },
                    ),
                    if (isSearchFocused && state.searchHistory.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.searchHistory.length,
                          itemBuilder: (BuildContext context, int index) {
                            final SearchRequest requestFromHistory =
                                state.searchHistory[index];

                            return SearchRequestTile(
                              query: requestFromHistory.query,
                              onTap: () {
                                searchController.text =
                                    requestFromHistory.query;
                                context.read<SearchBloc>().add(
                                      SearchPhotosEvent(
                                        query: requestFromHistory.query,
                                      ),
                                    );
                                searchFocusNode.unfocus();
                              },
                            );
                          },
                        ),
                      ),
                    if (!isSearchFocused || state.searchHistory.isEmpty)
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
