import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/state/user_app_activity.dart';

class UserAppActivity extends ConsumerWidget {
  const UserAppActivity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userAppActivityDataProvider);

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: data.when(
            data: (data) => Column(
              children: [
                const AdaptiveTextTitle('User App Activity'),
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'ID',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'State',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'Created At',
                        ),
                      ),
                    ),
                  ],
                  rows: data.map<DataRow>((e) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(AdaptiveTextBody(e.id.toString())),
                        DataCell(AdaptiveTextBody(e.state.name)),
                        DataCell(AdaptiveTextBody(e.createdAt.toString())),
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
