import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgentContact extends Equatable {
  final String id;
  final String name;
  final String title;
  final String agency;
  final String phone;
  final String email;
  final String avatarUrl;

  const AgentContact({
    required this.id,
    required this.name,
    required this.title,
    required this.agency,
    required this.phone,
    required this.email,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, title, agency, phone, email, avatarUrl];
}

abstract class CommunicationEvent extends Equatable {
  const CommunicationEvent();
  @override
  List<Object?> get props => [];
}

class FetchContactsEvent extends CommunicationEvent {}

abstract class CommunicationState extends Equatable {
  const CommunicationState();
  @override
  List<Object?> get props => [];
}

class CommunicationInitial extends CommunicationState {}
class CommunicationLoading extends CommunicationState {}
class CommunicationLoaded extends CommunicationState {
  final List<AgentContact> contacts;
  const CommunicationLoaded(this.contacts);
  @override
  List<Object?> get props => [contacts];
}

class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  CommunicationBloc() : super(CommunicationInitial()) {
    on<FetchContactsEvent>((event, emit) async {
      emit(CommunicationLoading());
      await Future.delayed(const Duration(milliseconds: 400));
      emit(const CommunicationLoaded([
        AgentContact(
          id: 'c-1',
          name: 'Sarah Jenkins',
          title: 'Senior Luxury Specialist',
          agency: 'Apex Luxury Realty',
          phone: '+1 (555) 234-5678',
          email: 'sarah.jenkins@apexrealty.com',
          avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
        ),
        AgentContact(
          id: 'c-2',
          name: 'Marcus Vance',
          title: 'Commercial & Penthouse Director',
          agency: 'Vance International Properties',
          phone: '+1 (555) 876-5432',
          email: 'm.vance@vanceprops.com',
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=400&q=80',
        ),
        AgentContact(
          id: 'c-3',
          name: 'Elena Rostova',
          title: 'Private Client Advisor',
          agency: 'Horizon Prime Estates',
          phone: '+1 (555) 345-6789',
          email: 'elena@horizonprime.com',
          avatarUrl: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=400&q=80',
        ),
      ]));
    });
  }
}
