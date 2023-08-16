import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusChip extends ConsumerWidget {
  final String? status;

  const StatusChip({super.key, this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const style = TextStyle(color: Colors.white);
    switch (status) {
      case 'success':
        return const Chip(
          avatar: Icon(Icons.check_circle, color: Colors.white),
          backgroundColor: Colors.green,
          label: Text('Success', style: style),
        );
      case 'error':
        return const Chip(
          avatar: Icon(Icons.info, color: Colors.white),
          backgroundColor: Colors.red,
          label: Text('Failed', style: style),
        );
      case 'stopped':
        return const Chip(
          avatar: Icon(Icons.stop_circle, color: Colors.white),
          backgroundColor: Colors.grey,
          label: Text('Stopped', style: style),
        );
      case 'waiting':
        return const Chip(
          avatar: Icon(Icons.schedule, color: Colors.white),
          backgroundColor: Colors.yellow,
          label: Text('Waiting', style: style),
        );
      case 'running':
        return const Chip(
          avatar: Icon(Icons.play_circle, color: Colors.white),
          backgroundColor: Colors.blue,
          label: Text('Running', style: style),
        );
      default:
        return Chip(
          label: Text(status ?? 'N/A'),
        );
    }
  }
}
