import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../properties/domain/property_model.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;
  const SearchQueryChangedEvent(this.query);
  @override
  List<Object?> get props => [query];
}

class FilterUpdatedEvent extends SearchEvent {
  final double maxPrice;
  final String propertyType;
  final int bedrooms;
  final double radiusKm;

  const FilterUpdatedEvent({
    required this.maxPrice,
    required this.propertyType,
    required this.bedrooms,
    required this.radiusKm,
  });

  @override
  List<Object?> get props => [maxPrice, propertyType, bedrooms, radiusKm];
}

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}
class SearchLoadingState extends SearchState {}
class SearchLoadedState extends SearchState {
  final String query;
  final List<Property> results;
  final double maxPrice;
  final String propertyType;
  final int bedrooms;
  final double radiusKm;
  final bool isMapView;

  const SearchLoadedState({
    required this.query,
    required this.results,
    this.maxPrice = 5000000,
    this.propertyType = 'All',
    this.bedrooms = 0,
    this.radiusKm = 10,
    this.isMapView = false,
  });

  SearchLoadedState copyWith({
    String? query,
    List<Property>? results,
    double? maxPrice,
    String? propertyType,
    int? bedrooms,
    double? radiusKm,
    bool? isMapView,
  }) {
    return SearchLoadedState(
      query: query ?? this.query,
      results: results ?? this.results,
      maxPrice: maxPrice ?? this.maxPrice,
      propertyType: propertyType ?? this.propertyType,
      bedrooms: bedrooms ?? this.bedrooms,
      radiusKm: radiusKm ?? this.radiusKm,
      isMapView: isMapView ?? this.isMapView,
    );
  }

  @override
  List<Object?> get props => [query, results, maxPrice, propertyType, bedrooms, radiusKm, isMapView];
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchQueryChangedEvent>((event, emit) async {
      emit(SearchLoadingState());
      await Future.delayed(const Duration(milliseconds: 300));
      final all = Property.sampleProperties;
      final filtered = all.where((p) => p.title.toLowerCase().contains(event.query.toLowerCase()) || p.location.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(SearchLoadedState(query: event.query, results: filtered.isEmpty ? all : filtered));
    });

    on<FilterUpdatedEvent>((event, emit) async {
      emit(SearchLoadingState());
      await Future.delayed(const Duration(milliseconds: 400));
      emit(SearchLoadedState(
        query: '',
        results: Property.sampleProperties,
        maxPrice: event.maxPrice,
        propertyType: event.propertyType,
        bedrooms: event.bedrooms,
        radiusKm: event.radiusKm,
      ));
    });
  }
}
