import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../properties/domain/property_model.dart';

abstract class PropertyDetailEvent extends Equatable {
  const PropertyDetailEvent();
  @override
  List<Object?> get props => [];
}

class FetchPropertyDetailEvent extends PropertyDetailEvent {
  final String propertyId;
  const FetchPropertyDetailEvent(this.propertyId);
  @override
  List<Object?> get props => [propertyId];
}

class ScheduleVisitEvent extends PropertyDetailEvent {
  final DateTime date;
  final String timeSlot;
  const ScheduleVisitEvent({required this.date, required this.timeSlot});
  @override
  List<Object?> get props => [date, timeSlot];
}

class SubmitInquiryEvent extends PropertyDetailEvent {
  final String message;
  const SubmitInquiryEvent(this.message);
  @override
  List<Object?> get props => [message];
}

abstract class PropertyDetailState extends Equatable {
  const PropertyDetailState();
  @override
  List<Object?> get props => [];
}

class PropertyDetailInitial extends PropertyDetailState {}
class PropertyDetailLoading extends PropertyDetailState {}
class PropertyDetailLoaded extends PropertyDetailState {
  final Property property;
  final bool visitScheduled;
  final bool inquirySubmitted;

  const PropertyDetailLoaded({
    required this.property,
    this.visitScheduled = false,
    this.inquirySubmitted = false,
  });

  PropertyDetailLoaded copyWith({
    Property? property,
    bool? visitScheduled,
    bool? inquirySubmitted,
  }) {
    return PropertyDetailLoaded(
      property: property ?? this.property,
      visitScheduled: visitScheduled ?? this.visitScheduled,
      inquirySubmitted: inquirySubmitted ?? this.inquirySubmitted,
    );
  }

  @override
  List<Object?> get props => [property, visitScheduled, inquirySubmitted];
}
class PropertyDetailError extends PropertyDetailState {
  final String message;
  const PropertyDetailError(this.message);
  @override
  List<Object?> get props => [message];
}

class PropertyDetailBloc extends Bloc<PropertyDetailEvent, PropertyDetailState> {
  PropertyDetailBloc() : super(PropertyDetailInitial()) {
    on<FetchPropertyDetailEvent>((event, emit) async {
      emit(PropertyDetailLoading());
      await Future.delayed(const Duration(milliseconds: 400));
      final all = Property.sampleProperties;
      final found = all.firstWhere(
        (p) => p.id == event.propertyId,
        orElse: () => all.first,
      );
      emit(PropertyDetailLoaded(property: found));
    });

    on<ScheduleVisitEvent>((event, emit) async {
      if (state is PropertyDetailLoaded) {
        final current = state as PropertyDetailLoaded;
        emit(current.copyWith(visitScheduled: true));
      }
    });

    on<SubmitInquiryEvent>((event, emit) async {
      if (state is PropertyDetailLoaded) {
        final current = state as PropertyDetailLoaded;
        emit(current.copyWith(inquirySubmitted: true));
      }
    });
  }
}
