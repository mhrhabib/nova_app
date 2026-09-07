import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../properties/domain/property_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchHomeDataEvent extends HomeEvent {}

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<Property> featuredProperties;
  final List<Property> recommendedProperties;
  final String activeCategory;

  const HomeLoaded({
    required this.featuredProperties,
    required this.recommendedProperties,
    this.activeCategory = 'All',
  });

  @override
  List<Object?> get props => [featuredProperties, recommendedProperties, activeCategory];
}
class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      await Future.delayed(const Duration(milliseconds: 600));
      final properties = Property.sampleProperties;
      emit(HomeLoaded(
        featuredProperties: properties.take(2).toList(),
        recommendedProperties: properties,
      ));
    });
  }
}
