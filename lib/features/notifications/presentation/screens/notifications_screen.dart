import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/widgets/ios_back_button.dart';
import '../../../../core/routing/route_names.dart';
import '../bloc/notifications_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc()..add(FetchNotificationsEvent()),
      child: const _NotificationsScreenContent(),
    );
  }
}

class _NotificationsScreenContent extends StatelessWidget {
  const _NotificationsScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: IosBackButton(size: 38),
        ),
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 4,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: LoadingShimmer(width: double.infinity, height: 80),
              ),
            );
          }

          if (state is NotificationsLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: item.isRead ? theme.colorScheme.surface : theme.colorScheme.primary.withValues(alpha: 0.05),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: item.isRead
                          ? theme.colorScheme.surfaceContainerHighest
                          : theme.colorScheme.primary.withValues(alpha: 0.15),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        color: item.isRead ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.primary,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(item.timestamp, style: theme.textTheme.bodySmall),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(item.body, style: theme.textTheme.bodyMedium),
                    ),
                    onTap: () {
                      context.read<NotificationsBloc>().add(MarkNotificationReadEvent(item.id));
                      context.go('${RouteNames.propertyDetail}/${item.targetPropertyId}');
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
