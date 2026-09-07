import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/property_model.dart';
import '../../../../core/widgets/property_card.dart';

abstract class PropertiesEvent extends Equatable {
  const PropertiesEvent();
  @override
  List<Object?> get props => [];
}

class FetchPropertiesEvent extends PropertiesEvent {}

class ToggleViewModeEvent extends PropertiesEvent {}

class SortPropertiesEvent extends PropertiesEvent {
  final String sortBy;
  const SortPropertiesEvent(this.sortBy);
  @override
  List<Object?> get props => [sortBy];
}

abstract class PropertiesState extends Equatable {
  const PropertiesState();
  @override
  List<Object?> get props => [];
}

class PropertiesInitial extends PropertiesState {}
class PropertiesLoading extends PropertiesState {}
class PropertiesLoaded extends PropertiesState {
  final List<Property> properties;
  final PropertyCardVariant viewMode;
  final String sortBy;

  const PropertiesLoaded({
    required this.properties,
    this.viewMode = PropertyCardVariant.grid,
    this.sortBy = 'Newest',
  });

  PropertiesLoaded copyWith({
    List<Property>? properties,
    PropertyCardVariant? viewMode,
    String? sortBy,
  }) {
    return PropertiesLoaded(
      properties: properties ?? this.properties,
      viewMode: viewMode ?? this.viewMode,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object?> get props => [properties, viewMode, sortBy];
}

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  PropertiesBloc() : super(PropertiesInitial()) {
    on<FetchPropertiesEvent>((event, emit) async {
      emit(PropertiesLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(PropertiesLoaded(properties: Property.sampleProperties));
    });

    on<ToggleViewModeEvent>((event, emit) {
      if (state is PropertiesLoaded) {
        final current = state as PropertiesLoaded;
        final nextMode = current.viewMode == PropertyCardVariant.grid
            ? PropertyCardVariant.list
            : PropertyCardVariant.grid;
        emit(current.copyWith(viewMode: nextMode));
      }
    });

    on<SortPropertiesEvent>((event, emit) {
      if (state is PropertiesLoaded) {
        final current = state as PropertiesLoaded;
        final list = List<Property>.from(current.properties);
        if (event.sortBy == 'Price: Low to High') {
          list.sort((a, b) => a.price.compareTo(b.price));
        } else if (event.sortBy == 'Price: High to Low') {
          list.sort((a, b) => b.price.compareTo(a.price));
        }
        emit(current.copyWith(properties: list, sortBy: event.sortBy));
      }
    });
  }
}
