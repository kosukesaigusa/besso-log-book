import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'loading/loading.dart';
import 'loading/ui/overlay_loading.dart';
import 'router/router.dart';
import 'scaffold_messenger_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
}

final _appRouterProvider = Provider.autoDispose<AppRouter>((_) => AppRouter());

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter 別荘 LogBook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      routerConfig: ref.watch(_appRouterProvider).config(),
      builder: (context, child) {
        final isLoading = ref.watch(showOverlayLoadingStateProvider);
        return Navigator(
          key: ref.watch(navigatorKeyProvider),
          onPopPage: (_, __) => false,
          pages: [
            MaterialPage<Widget>(
              child: Stack(
                children: [
                  child!,
                  if (isLoading) const OverlayLoading(),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
