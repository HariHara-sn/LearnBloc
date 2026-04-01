import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../google_sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleSignInBloc, GoogleLoginState>(
      listener: (context, state) {
        if (state is GoogleSignInInitialState) {
          Navigator.pushReplacementNamed(context, "/login");
        }
      },
      builder: (context, state) {
        if (state is! GoogleSignInSuccessState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return _buildHome(context, state);
      },
    );
  }

  Widget _buildHome(BuildContext context, GoogleSignInSuccessState state) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0.5,
      ),

      // ── Drawer ──────────────────────────────────────────────────────────
      drawer: Drawer(
        child: Column(
          children: [
            // User header inside drawer
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF4285F4)),
              accountName: Text(
                state.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              accountEmail: Text(state.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: state.photoUrl.isNotEmpty
                    ? NetworkImage(state.photoUrl)
                    : null,
                backgroundColor: Colors.white,
                child: state.photoUrl.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF4285F4),
                      )
                    : null,
              ),
            ),

            // Logout tile
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // close drawer
                context.read<GoogleSignInBloc>().add(
                  GoogleSignOutRequestedEvent(),
                );
              },
            ),
          ],
        ),
      ),

      // ── Body ────────────────────────────────────────────────────────────
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile photo
            CircleAvatar(
              radius: 60,
              backgroundImage: state.photoUrl.isNotEmpty
                  ? NetworkImage(state.photoUrl)
                  : null,
              backgroundColor: const Color(0xFF4285F4),
              child: state.photoUrl.isEmpty
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 20),

            // Name
            Text(
              state.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),

            // Email
            Text(
              state.email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Welcome card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF34A853),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Successfully signed in with Google!',
                      style: TextStyle(fontSize: 14, color: Color(0xFF3C4043)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
