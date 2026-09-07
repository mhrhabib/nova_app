import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../properties/domain/property_model.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override
  List<Object?> get props => [];
}

class FetchDashboardDataEvent extends DashboardEvent {}

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final int savedCount;
  final int upcomingVisits;
  final int activeInquiries;
  final List<Property> savedProperties;

  const DashboardLoaded({
    required this.savedCount,
    required this.upcomingVisits,
    required this.activeInquiries,
    required this.savedProperties,
  });

  @override
  List<Object?> get props => [savedCount, upcomingVisits, activeInquiries, savedProperties];
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchDashboardDataEvent>((event, emit) async {
      emit(DashboardLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final saved = Property.sampleProperties.where((p) => p.isSaved).toList();
      emit(DashboardLoaded(
        savedCount: saved.length,
        upcomingVisits: 2,
        activeInquiries: 4,
        savedProperties: saved,
      ));
    });
  }
}
