part of 'main_page_bloc.dart';

abstract class MainPageEvent {
  const MainPageEvent();
}

class InitEvent extends MainPageEvent {
  const InitEvent();
}

class GetTrendingPhotosNextPageEvent extends MainPageEvent {
  const GetTrendingPhotosNextPageEvent();
}

