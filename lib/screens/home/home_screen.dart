import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/app_drawer.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/project/history_screen.dart';
import 'package:semaphore/state/projects.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const name = 'home';
  static const path = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width > size.height ? size.height : size.width;
    final textSize = width * 0.618 * 0.1;

    ref.read(projectsProvider.notifier).getProjects();
    final currentProject = ref.watch(currentProjectProvider);

    return AdaptiveScaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(),
      body: SafeArea(
        child: Center(
          child: SizedBox(
              width: width * 0.618,
              height: width * 0.618,
              child: Center(
                child: currentProject.when(
                  data: (current) {
                    Timer(const Duration(milliseconds: 618), () {
                      ref.read(routerProvider).goNamed(HistoryScreen.name,
                          pathParameters: <String, String>{
                            'pid': '${current?.id ?? 1}',
                          });
                    });
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ansible', style: TextStyle(fontSize: textSize)),
                        SizedBox(height: textSize),
                        Text('Semaphore', style: TextStyle(fontSize: textSize)),
                      ],
                    ));
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
              )),
        ),
      ),
    );
  }
}
