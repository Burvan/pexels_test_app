import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:core_ui/core_ui.dart';
import 'package:home/home.dart';
import 'package:main_page/src/bloc/main_page_bloc.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainPageBloc>(
      create: (_) => MainPageBloc(
        getTrendingPhotosUseCase: appLocator.get<GetTrendingPhotosUseCase>(),
      ),
      child: const _MainScreen(),
    );
  }
}

class _MainScreen extends StatelessWidget {
  const _MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding10,
                  ),
                  child: PhotoGrid(
                    photos: state.photos,
                    isLoading: state.isLoading,
                    isEndOfList: state.isEndOfList,
                    onLoadMore: () {
                      context.read<MainPageBloc>().add(
                            GetTrendingPhotosNextPageEvent(),
                          );
                    },
                    onPhotoTap: (Photo photo) {
                      context.navigateTo(
                        DetailedPhotoRoute(photo: photo),
                      );
                    },
                  ),
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
