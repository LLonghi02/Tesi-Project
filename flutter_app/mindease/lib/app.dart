import 'package:mindease/provider/importer.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ref.watch(accentColorProvider),
          brightness: ref.watch(brightnessProvider),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home:    Schermata(),
    );
  }
}

