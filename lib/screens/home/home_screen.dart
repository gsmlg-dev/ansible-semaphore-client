import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
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
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;

    final size = MediaQuery.of(context).size;
    final width = size.width > size.height ? size.height : size.width;
    final textSize = width * 0.618 * 0.1;

    final currentProject = ref.watch(currentProjectProvider);

    return Scaffold(
      drawer: const LocalDrawer(),
      appBar: const LocalAppBar(),
      body: NeumorphicBackground(
        child: SafeArea(
          child: Center(
            child: Neumorphic(
                style: neumorphicTheme
                    .getNeumorphicStyle()
                    .copyWith(boxShape: const NeumorphicBoxShape.circle()),
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
                              NeumorphicText('Ansible',
                                  textStyle: TextStyle(fontSize: textSize)),
                              SizedBox(height: textSize),
                              NeumorphicText('Semaphore',
                                  textStyle: TextStyle(fontSize: textSize)),
                            ],
                          ));
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const CircularProgressIndicator(),
                      ),
                    ))),
          ),
        ),
      ),
    );
  }
}
