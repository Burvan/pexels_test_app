import 'package:core/core.dart';
import '../navigation.dart';

void setupNavigationDependencies() {
  appLocator.registerSingleton(AppRouter());
}