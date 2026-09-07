import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends ProfileEvent {}

class ToggleNotificationPrefEvent extends ProfileEvent {
  final String key;
  const ToggleNotificationPrefEvent(this.key);
  @override
  List<Object?> get props => [key];
}

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final bool pushNotifications;
  final bool priceDropAlerts;
  final bool matchRecommendations;

  const ProfileLoaded({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    this.pushNotifications = true,
    this.priceDropAlerts = true,
    this.matchRecommendations = true,
  });

  ProfileLoaded copyWith({
    bool? pushNotifications,
    bool? priceDropAlerts,
    bool? matchRecommendations,
  }) {
    return ProfileLoaded(
      name: name,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      priceDropAlerts: priceDropAlerts ?? this.priceDropAlerts,
      matchRecommendations: matchRecommendations ?? this.matchRecommendations,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, avatarUrl, pushNotifications, priceDropAlerts, matchRecommendations];
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      await Future.delayed(const Duration(milliseconds: 300));
      emit(const ProfileLoaded(
        name: 'Alexander Wright',
        email: 'alexander.wright@nova.com',
        phone: '+1 (555) 019-2831',
        avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      ));
    });

    on<ToggleNotificationPrefEvent>((event, emit) {
      if (state is ProfileLoaded) {
        final current = state as ProfileLoaded;
        if (event.key == 'push') {
          emit(current.copyWith(pushNotifications: !current.pushNotifications));
        } else if (event.key == 'price') {
          emit(current.copyWith(priceDropAlerts: !current.priceDropAlerts));
        } else if (event.key == 'match') {
          emit(current.copyWith(matchRecommendations: !current.matchRecommendations));
        }
      }
    });
  }
}
