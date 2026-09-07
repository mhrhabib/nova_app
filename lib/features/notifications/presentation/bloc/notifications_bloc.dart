import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationItem extends Equatable {
  final String id;
  final String title;
  final String body;
  final String timestamp;
  final String targetPropertyId;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.targetPropertyId,
    this.isRead = false,
  });

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      targetPropertyId: targetPropertyId,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, title, body, timestamp, targetPropertyId, isRead];
}

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
  @override
  List<Object?> get props => [];
}

class FetchNotificationsEvent extends NotificationsEvent {}

class MarkNotificationReadEvent extends NotificationsEvent {
  final String notificationId;
  const MarkNotificationReadEvent(this.notificationId);
  @override
  List<Object?> get props => [notificationId];
}

abstract class NotificationsState extends Equatable {
  const NotificationsState();
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState {}
class NotificationsLoaded extends NotificationsState {
  final List<NotificationItem> items;
  const NotificationsLoaded(this.items);
  @override
  List<Object?> get props => [items];
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<FetchNotificationsEvent>((event, emit) async {
      emit(NotificationsLoading());
      await Future.delayed(const Duration(milliseconds: 300));
      emit(const NotificationsLoaded([
        NotificationItem(
          id: 'n-1',
          title: '🔥 Price Drop Alert',
          body: 'The Skyview Penthouse price was updated from \$2.6M to \$2.45M.',
          timestamp: '10m ago',
          targetPropertyId: 'prop-1',
          isRead: false,
        ),
        NotificationItem(
          id: 'n-2',
          title: '✅ Tour Confirmed',
          body: 'Sarah Jenkins confirmed your visit for Modern Minimalist Villa tomorrow at 10:00 AM.',
          timestamp: '2h ago',
          targetPropertyId: 'prop-2',
          isRead: false,
        ),
        NotificationItem(
          id: 'n-3',
          title: '⚡ New 98% AI Match',
          body: 'A new property matching your Malibu search parameters just hit the market.',
          timestamp: '1d ago',
          targetPropertyId: 'prop-4',
          isRead: true,
        ),
      ]));
    });

    on<MarkNotificationReadEvent>((event, emit) {
      if (state is NotificationsLoaded) {
        final current = state as NotificationsLoaded;
        final updated = current.items.map((n) {
          if (n.id == event.notificationId) return n.copyWith(isRead: true);
          return n;
        }).toList();
        emit(NotificationsLoaded(updated));
      }
    });
  }
}
