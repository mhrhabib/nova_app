import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityItem extends Equatable {
  final String id;
  final String title;
  final String time;
  final String location;
  final String type; // Tour, Task, Follow-up
  final bool isCompleted;

  const ActivityItem({
    required this.id,
    required this.title,
    required this.time,
    required this.location,
    required this.type,
    this.isCompleted = false,
  });

  ActivityItem copyWith({bool? isCompleted}) {
    return ActivityItem(
      id: id,
      title: title,
      time: time,
      location: location,
      type: type,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, time, location, type, isCompleted];
}

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();
  @override
  List<Object?> get props => [];
}

class FetchActivitiesEvent extends ActivitiesEvent {}

class ToggleTaskCompletedEvent extends ActivitiesEvent {
  final String taskId;
  const ToggleTaskCompletedEvent(this.taskId);
  @override
  List<Object?> get props => [taskId];
}

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();
  @override
  List<Object?> get props => [];
}

class ActivitiesInitial extends ActivitiesState {}
class ActivitiesLoading extends ActivitiesState {}
class ActivitiesLoaded extends ActivitiesState {
  final List<ActivityItem> activities;
  final DateTime selectedDate;

  const ActivitiesLoaded({
    required this.activities,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [activities, selectedDate];
}

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc() : super(ActivitiesInitial()) {
    on<FetchActivitiesEvent>((event, emit) async {
      emit(ActivitiesLoading());
      await Future.delayed(const Duration(milliseconds: 400));
      emit(ActivitiesLoaded(
        selectedDate: DateTime.now(),
        activities: const [
          ActivityItem(
            id: 'act-1',
            title: 'Private Tour: Skyview Penthouse',
            time: '10:00 AM - 11:00 AM',
            location: 'Downtown Waterfront',
            type: 'Tour',
          ),
          ActivityItem(
            id: 'act-2',
            title: 'Review Mortgage Prequalification Document',
            time: '01:30 PM',
            location: 'Online Document Portal',
            type: 'Task',
          ),
          ActivityItem(
            id: 'act-3',
            title: 'Follow-up with Sarah Jenkins (Apex Realty)',
            time: '04:00 PM',
            location: 'Phone Call',
            type: 'Follow-up',
          ),
        ],
      ));
    });

    on<ToggleTaskCompletedEvent>((event, emit) {
      if (state is ActivitiesLoaded) {
        final current = state as ActivitiesLoaded;
        final updated = current.activities.map((a) {
          if (a.id == event.taskId) {
            return a.copyWith(isCompleted: !a.isCompleted);
          }
          return a;
        }).toList();
        emit(ActivitiesLoaded(activities: updated, selectedDate: current.selectedDate));
      }
    });
  }
}
