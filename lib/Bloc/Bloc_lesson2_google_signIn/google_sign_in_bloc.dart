import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/login_repository.dart';

part 'google_sign_in_event.dart';
part 'google_sign_in_state.dart';

class GoogleSignInBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final GoogleSignInRepository _repository;

  GoogleSignInBloc({required GoogleSignInRepository repository}) : _repository = repository, super(GoogleSignInInitialState()) {
    on<GoogleSignInRequestedEvent>(_onGoogleSignInRequested);
    on<GoogleSignOutRequestedEvent>(_onGoogleSignOutRequested);
    on<GoogleSignInRequestFailureEvent>(_onGoogleSignInRequestFailure);
    on<GoogleSignInRestoreSessionEvent>(_onGoogleSignInRestoreSession);
  }

  Future<void> _onGoogleSignInRequested(GoogleSignInRequestedEvent event, Emitter<GoogleLoginState> emit) async {
    emit(GoogleSignInLoadingState());
    try {
      final user = await _repository.signInWithGoogle();
      emit(GoogleSignInSuccessState(
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
      ));
    } catch (e) {
      emit(GoogleSignInFailureState(e.toString()));
    }
  }

  Future<void> _onGoogleSignOutRequested(
    GoogleSignOutRequestedEvent event,
    Emitter<GoogleLoginState> emit,
  ) async {
    try {
      await _repository.signOut();
      emit(GoogleSignInInitialState());
    } catch (e) {
      emit(GoogleSignInFailureState(e.toString()));
    }
  }

  void _onGoogleSignInRequestFailure(
    GoogleSignInRequestFailureEvent event,
    Emitter<GoogleLoginState> emit,
  ) {
    emit(GoogleSignInFailureState(event.errorMessage));
  }

  void _onGoogleSignInRestoreSession(
    GoogleSignInRestoreSessionEvent event,
    Emitter<GoogleLoginState> emit,
  ) {
    final user = _repository.getCurrentUser();
    if (user != null) {
      emit(GoogleSignInSuccessState(
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
      ));
    } else {
      emit(GoogleSignInFailureState('User session not found'));
    }
  }
}