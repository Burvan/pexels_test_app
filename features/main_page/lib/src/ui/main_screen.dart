import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:core_ui/core_ui.dart';
import 'package:main_page/src/bloc/main_page_bloc.dart';
import 'package:main_page/src/ui/widgets/photo_tile.dart';
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

class _MainScreen extends StatefulWidget {
  const _MainScreen({super.key});

  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll - 100;
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MainPageBloc>().add(
            GetTrendingPhotosNextPageEvent(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSize.size8,
                    childAspectRatio: AppScale.scale1,
                  ),
                  itemCount: state.isEndOfList
                      ? state.photos.length
                      : state.photos.length + 1,
                  itemBuilder: (_, int index) {
                    if (index >= state.photos.length) {
                      return const SizedBox();
                    } else {
                      return PhotoTile(
                        photo: state.photos.elementAt(index),
                        onTap: () {},
                      );
                    }
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
    });
  }
}
