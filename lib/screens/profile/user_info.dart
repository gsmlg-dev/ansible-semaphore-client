import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/switch.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/state/auth.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: user.when(
            data: (user) => Column(
              children: [
                const AdaptiveTextTitle('User Info'),
                const SizedBox(height: 24),
                AdaptiveTextField(
                  autocorrect: false,
                  initialValue: user?.name,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      labelText: 'Name', contentPadding: EdgeInsets.all(8)),
                ),
                const SizedBox(height: 24),
                AdaptiveTextField(
                  autocorrect: false,
                  initialValue: user?.username,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      labelText: 'Username', contentPadding: EdgeInsets.all(8)),
                ),
                const SizedBox(height: 24),
                AdaptiveTextField(
                  autocorrect: false,
                  initialValue: user?.email,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      labelText: 'Email', contentPadding: EdgeInsets.all(8)),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    AdaptiveSwitch(
                      value: user?.alert ?? false,
                      onChanged: (value) {},
                    ),
                    const SizedBox(width: 12),
                    const AdaptiveTextBody('Send alert'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    AdaptiveSwitch(
                      value: user?.admin ?? false,
                    ),
                    const SizedBox(width: 12),
                    const AdaptiveTextBody('Admin user'),
                  ],
                ),
                const SizedBox(height: 24),
                AdaptiveButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
                const SizedBox(height: 24),
              ],
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
          ),
        ),
      ),
    );
  }
}
