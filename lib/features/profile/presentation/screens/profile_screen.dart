import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/routing/route_names.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(FetchProfileEvent()),
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatelessWidget {
  const _ProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading || state is ProfileInitial) {
                  return const LoadingShimmer(width: double.infinity, height: 100);
                }

                if (state is ProfileLoaded) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundImage: NetworkImage(state.avatarUrl),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.name,
                                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(state.email, style: theme.textTheme.bodySmall),
                                Text(state.phone, style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 28),

            // Appearance & Theming Section
            SectionHeader(
              title: 'App Appearance',
              subtitle: 'Switch between light, dark, or system default colors',
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Theme Mode', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(value: ThemeMode.system, label: Text('System'), icon: Icon(Icons.brightness_auto)),
                        ButtonSegment(value: ThemeMode.light, label: Text('Light'), icon: Icon(Icons.light_mode)),
                        ButtonSegment(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode)),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (newSelection) {
                        context.read<ThemeCubit>().toggleTheme(newSelection.first);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Notification Preferences
            SectionHeader(
              title: 'Notifications & Alerts',
              subtitle: 'Configure real-time property and tour alerts',
            ),
            const SizedBox(height: 8),

            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return Card(
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Push Notifications'),
                          subtitle: const Text('Receive instant tour updates and agent messages'),
                          value: state.pushNotifications,
                          onChanged: (_) {
                            context.read<ProfileBloc>().add(const ToggleNotificationPrefEvent('push'));
                          },
                        ),
                        const Divider(height: 1),
                        SwitchListTile(
                          title: const Text('Price Drop Alerts'),
                          subtitle: const Text('Get notified when bookmarked properties reduce prices'),
                          value: state.priceDropAlerts,
                          onChanged: (_) {
                            context.read<ProfileBloc>().add(const ToggleNotificationPrefEvent('price'));
                          },
                        ),
                        const Divider(height: 1),
                        SwitchListTile(
                          title: const Text('AI Match Recommendations'),
                          subtitle: const Text('Weekly digest of new high-scoring property matches'),
                          value: state.matchRecommendations,
                          onChanged: (_) {
                            context.read<ProfileBloc>().add(const ToggleNotificationPrefEvent('match'));
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 32),

            SecondaryButton(
              text: 'Sign Out',
              icon: Icons.logout,
              onPressed: () => context.go(RouteNames.auth),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
