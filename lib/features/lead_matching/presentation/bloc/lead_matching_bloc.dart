import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../properties/domain/property_model.dart';

abstract class LeadMatchingEvent extends Equatable {
  const LeadMatchingEvent();
  @override
  List<Object?> get props => [];
}

class FetchLeadMatchesEvent extends LeadMatchingEvent {}

abstract class LeadMatchingState extends Equatable {
  const LeadMatchingState();
  @override
  List<Object?> get props => [];
}

class LeadMatchingInitial extends LeadMatchingState {}
class LeadMatchingLoading extends LeadMatchingState {}
class LeadMatchingLoaded extends LeadMatchingState {
  final List<Property> matchedProperties;
  const LeadMatchingLoaded(this.matchedProperties);
  @override
  List<Object?> get props => [matchedProperties];
}

class LeadMatchingBloc extends Bloc<LeadMatchingEvent, LeadMatchingState> {
  LeadMatchingBloc() : super(LeadMatchingInitial()) {
    on<FetchLeadMatchesEvent>((event, emit) async {
      emit(LeadMatchingLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(LeadMatchingLoaded(Property.sampleProperties));
    });
  }
}
