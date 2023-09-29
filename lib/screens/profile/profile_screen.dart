import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/adaptive/tab_view.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/user/system_form.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/home/home_screen.dart';
import 'package:semaphore/screens/profile/user_app_activity.dart';
import 'package:semaphore/screens/profile/user_info.dart';
import 'package:semaphore/screens/profile/system_user_list.dart';
import 'package:semaphore/state/auth.dart';

enum ProfileScreenModule { info, list, activity }

extension ProfileScreenModuleWidget on ProfileScreenModule {
  bool get adminOnly {
    switch (this) {
      case ProfileScreenModule.list:
        return true;
      default:
        return false;
    }
  }

  Widget get wiget {
    switch (this) {
      case ProfileScreenModule.info:
        return const UserInfo();
      case ProfileScreenModule.list:
        return const SystemUserList();
      case ProfileScreenModule.activity:
        return const UserAppActivity();
    }
  }

  List<Widget> actions(BuildContext context) {
    switch (this) {
      case ProfileScreenModule.info:
        return [];
      case ProfileScreenModule.list:
        return [
          AdaptiveIconButton(
            onPressed: () {
              adaptiveDialog(
                  context: context, child: const SystemUserForm(userId: null));
            },
            icon: const AdaptiveIcon(Icons.add),
          )
        ];
      case ProfileScreenModule.activity:
        return [];
    }
  }
}

class ProfileScreen extends ConsumerWidget {
  final ProfileScreenModule module;

  const ProfileScreen({super.key, required this.module});

  static const name = 'profile';
  static const path = '/profile/:module';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return AdaptiveScaffold(
        appBar: LocalAppBar(
            title: 'Profile',
            // actions: module.actions(context),
            leading: AdaptiveIconButton(
              icon: const AdaptiveIcon(Icons.arrow_back_ios),
              onPressed: () {
                ref.read(routerProvider).goNamed(HomeScreen.name);
              },
            )),
        body: SafeArea(
          child: user.when(
            data: (user) => AdaptiveTabView(
              initialIndex: ProfileScreenModule.values.indexOf(module),
              tabs: ProfileScreenModule.values
                  .where((element) =>
                      element.adminOnly ? user?.admin == true : true)
                  .map<String>((m) => m.name)
                  .toList(),
              children: ProfileScreenModule.values
                  .where((element) =>
                      element.adminOnly ? user?.admin == true : true)
                  .map<Widget>((m) => m.wiget)
                  .toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: AdaptiveTextError(error.toString()),
            ),
          ),
        ));
  }
}
