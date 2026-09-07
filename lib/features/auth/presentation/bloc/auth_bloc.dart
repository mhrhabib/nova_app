import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SendOTPEvent extends AuthEvent {
  final String phoneNumber;
  const SendOTPEvent(this.phoneNumber);
  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOTPEvent extends AuthEvent {
  final String otp;
  const VerifyOTPEvent(this.otp);
  @override
  List<Object?> get props => [otp];
}

class CompleteProfileEvent extends AuthEvent {
  final String fullName;
  final String email;
  const CompleteProfileEvent({required this.fullName, required this.email});
  @override
  List<Object?> get props => [fullName, email];
}

class ResetAuthEvent extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class OTPSentState extends AuthState {
  final String phoneNumber;
  const OTPSentState(this.phoneNumber);
  @override
  List<Object?> get props => [phoneNumber];
}
class AuthNeedsProfileSetup extends AuthState {
  final String phoneNumber;
  const AuthNeedsProfileSetup(this.phoneNumber);
  @override
  List<Object?> get props => [phoneNumber];
}
class AuthAuthenticated extends AuthState {
  final String fullName;
  final String email;
  final String phoneNumber;
  const AuthAuthenticated({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });
  @override
  List<Object?> get props => [fullName, email, phoneNumber];
}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String _currentPhone = '';

  AuthBloc() : super(AuthInitial()) {
    on<SendOTPEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      if (event.phoneNumber.length < 10) {
        emit(const AuthError('Please enter a valid phone number.'));
        return;
      }
      _currentPhone = event.phoneNumber;
      emit(OTPSentState(event.phoneNumber));
    });

    on<VerifyOTPEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      if (event.otp != '123456' && event.otp.length != 6) {
        emit(const AuthError('Invalid code. Use code 123456 to log in.'));
        return;
      }
      emit(AuthNeedsProfileSetup(_currentPhone));
    });

    on<CompleteProfileEvent>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 600));
      emit(AuthAuthenticated(
        fullName: event.fullName,
        email: event.email,
        phoneNumber: _currentPhone.isEmpty ? '+1 (555) 019-2831' : _currentPhone,
      ));
    });
    on<ResetAuthEvent>((event, emit) {
      _currentPhone = '';
      emit(AuthInitial());
    });
  }
}
