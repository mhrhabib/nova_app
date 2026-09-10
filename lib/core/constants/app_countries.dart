import 'package:equatable/equatable.dart';

class NovaCountry extends Equatable {
  final String code;
  final String name;
  final String shortName;
  final String flag;
  final String currencyCode;
  final String currencySymbol;
  final String officeCity;
  final String dialCode;
  final String portalDomain;

  const NovaCountry({
    required this.code,
    required this.name,
    required this.shortName,
    required this.flag,
    required this.currencyCode,
    required this.currencySymbol,
    required this.officeCity,
    required this.dialCode,
    required this.portalDomain,
  });

  @override
  List<Object?> get props => [
        code,
        name,
        shortName,
        flag,
        currencyCode,
        currencySymbol,
        officeCity,
        dialCode,
        portalDomain,
      ];
}

abstract class AppCountries {
  static const NovaCountry uae = NovaCountry(
    code: 'AE',
    name: 'United Arab Emirates',
    shortName: 'UAE',
    flag: '🇦🇪',
    currencyCode: 'AED',
    currencySymbol: 'د.إ',
    officeCity: 'Dubai Marina & Downtown',
    dialCode: '+971',
    portalDomain: 'novadevelopment.ae',
  );

  static const NovaCountry bangladesh = NovaCountry(
    code: 'BD',
    name: 'Bangladesh',
    shortName: 'BD',
    flag: '🇧🇩',
    currencyCode: 'BDT',
    currencySymbol: '৳',
    officeCity: 'Gulshan-2, Dhaka',
    dialCode: '+880',
    portalDomain: 'novadevelopment.com.bd',
  );

  static const NovaCountry uk = NovaCountry(
    code: 'UK',
    name: 'United Kingdom',
    shortName: 'UK',
    flag: '🇬🇧',
    currencyCode: 'GBP',
    currencySymbol: '£',
    officeCity: 'Mayfair, London',
    dialCode: '+44',
    portalDomain: 'novadevelopment.uk',
  );

  static const NovaCountry usa = NovaCountry(
    code: 'US',
    name: 'United States',
    shortName: 'USA',
    flag: '🇺🇸',
    currencyCode: 'USD',
    currencySymbol: '\$',
    officeCity: 'Manhattan, New York',
    dialCode: '+1',
    portalDomain: 'novadevelopment.us',
  );

  static const List<NovaCountry> all = [
    uae,
    bangladesh,
    uk,
    usa,
  ];

  static NovaCountry fromCode(String code) {
    return all.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse: () => uae,
    );
  }
}
