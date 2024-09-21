import 'package:common_data/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ticket_web/feature/auth/data/current_user.dart';

part 'home_page.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              label: const Text('Sign in with Google'),
              icon: const Icon(Icons.login),
              onPressed: () async {
                await ref.read(authRepositoryProvider).signInWithGoogle();
              },
            ),
            const SizedBox(height: 16),
            Text(
              ref.watch(currentUserProvider).toString(),
            ),
          ],
        ),
      ),
    );
  }
}
