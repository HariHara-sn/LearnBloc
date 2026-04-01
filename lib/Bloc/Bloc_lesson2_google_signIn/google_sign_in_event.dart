part of 'google_sign_in_bloc.dart';

abstract class GoogleLoginEvent {}

final class GoogleSignInRequestedEvent extends GoogleLoginEvent {}

final class GoogleSignOutRequestedEvent extends GoogleLoginEvent {}

final class GoogleSignInRequestFailureEvent extends GoogleLoginEvent {
  final String errorMessage;
  GoogleSignInRequestFailureEvent(this.errorMessage);
}

final class GoogleSignInRestoreSessionEvent extends GoogleLoginEvent {}
