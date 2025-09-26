import 'package:firebase_auth/firebase_auth.dart';

String authErrorMessage(FirebaseAuthException e, {bool isSignIn = false}) {
  switch (e.code) {
    case 'invalid-email':
      return 'That email looks invalid. Please check and try again.';
    case 'user-not-found':
      return isSignIn
          ? 'No account found for that email. Create one first.'
          : 'User not found.';
    case 'wrong-password':
    case 'invalid-credential':
      return 'Incorrect email or password. Please try again.';
    case 'email-already-in-use':
      return 'That email is already registered. Try signing in or reset your password.';
    case 'weak-password':
      return 'Please use a stronger password (at least 6 characters).';
    case 'too-many-requests':
      return 'Too many attempts. Please wait a minute and try again.';
    case 'network-request-failed':
      return 'Network issue. Check your connection and try again.';
    case 'operation-not-allowed':
      return 'This sign-in method is disabled for the project.';
    default:
      return 'Unexpected error: ${e.message ?? e.code}';
  }
}
