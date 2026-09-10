import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_countries.dart';

class CountryCubit extends Cubit<NovaCountry> {
  static const String _prefKey = 'selected_country_code';
  final SharedPreferences _prefs;

  CountryCubit(this._prefs) : super(_loadInitialCountry(_prefs));

  static NovaCountry _loadInitialCountry(SharedPreferences prefs) {
    final savedCode = prefs.getString(_prefKey);
    if (savedCode != null) {
      return AppCountries.fromCode(savedCode);
    }
    return AppCountries.uae; // Default operating hub
  }

  void selectCountry(NovaCountry country) {
    _prefs.setString(_prefKey, country.code);
    emit(country);
  }
}
