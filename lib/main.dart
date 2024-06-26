import 'package:flutter/material.dart';
import 'package:simple_app/presentation/app_router.dart';
import 'package:simple_app/presentation/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const NotesApp());
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  RouterConfig<Object>? router;

  @override
  void initState() {
    super.initState();
    router = AppRouter.getConfig(RouterPaths.notesList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
