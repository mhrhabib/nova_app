import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Theme Cubit
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl<SharedPreferences>()));
}
