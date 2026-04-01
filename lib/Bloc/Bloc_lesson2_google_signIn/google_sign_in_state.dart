part of 'google_sign_in_bloc.dart';

abstract class GoogleLoginState {}

final class GoogleSignInInitialState extends GoogleLoginState {}

final class GoogleSignInLoadingState extends GoogleLoginState {}

final class GoogleSignInSuccessState extends GoogleLoginState {
  final String name;
  final String email;
  final String photoUrl;

  GoogleSignInSuccessState({
    required this.name,
    required this.email,
    required this.photoUrl,
  });
}

final class GoogleSignInFailureState extends GoogleLoginState {
  final String message;

  GoogleSignInFailureState(this.message);
}