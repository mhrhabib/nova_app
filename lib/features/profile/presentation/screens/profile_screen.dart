import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/cubits/country_cubit.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/widgets/country_selector_sheet.dart';
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

  void _showDigitalPassModal(BuildContext context, ThemeData theme, String userName) {
    final currentCountry = context.read<CountryCubit>().state;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'NOVA VIP PASS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(currentCountry.flag, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(ctx).pop()),
                ],
              ),
              const SizedBox(height: 16),
              // Simulated QR Code Pass Container
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_2, size: 140, color: theme.colorScheme.onSurface),
                    const SizedBox(height: 4),
                    Text(
                      'ID: #ND-VIP-88219',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(userName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                'Tier: VIP Member & Global Investor',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified, size: 18, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Verified for fast-track office & VIP airport lounge entry across UAE, BD, UK, & USA.',
                        style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(text: 'Done', onPressed: () => Navigator.of(ctx).pop()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = context.watch<ThemeCubit>().state;
    final currentCountry = context.watch<CountryCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
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
                  return Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(radius: 36, backgroundImage: NetworkImage(state.avatarUrl)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          state.name,
                                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.verified, size: 18, color: Colors.blue),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(state.email, style: theme.textTheme.bodySmall),
                                    Text(state.phone, style: theme.textTheme.bodySmall),
                                  ],
                                ),
                              ),
                              IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Customer Lifecycle Tier & VIP Pass (Module 09 & 22)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [const Color(0xFF1E293B), const Color(0xFF0F172A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFD97706).withValues(alpha: 0.5), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.workspace_premium, color: Color(0xFFF59E0B), size: 24),
                                    const SizedBox(width: 8),
                                    Text(
                                      'VIP MEMBER TIER',
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        color: const Color(0xFFF59E0B),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'Stage 8: Owner / VIP',
                                    style: TextStyle(
                                      color: Color(0xFFF59E0B),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Global Investor Pass • Direct Developer Access • Concierge Service',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () => _showDigitalPassModal(context, theme, state.name),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.qr_code, size: 18, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'View Digital Buyer Pass & QR Code',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 28),

            // Regional Operating Country (Module 04)
            SectionHeader(title: 'Regional Operations Hub', subtitle: 'Select current country and preferred currency'),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(currentCountry.flag, style: const TextStyle(fontSize: 24)),
                ),
                title: Text(
                  currentCountry.name,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${currentCountry.officeCity} • Currency: ${currentCountry.currencyCode} (${currentCountry.currencySymbol})',
                  style: theme.textTheme.bodySmall,
                ),
                trailing: OutlinedButton(
                  onPressed: () => CountrySelectorSheet.show(context),
                  child: const Text('Change'),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Appearance & Theming Section
            SectionHeader(title: 'App Appearance', subtitle: 'Switch between light, dark, or system default colors'),
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
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('System'),
                          icon: Icon(Icons.brightness_auto),
                        ),
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
            SectionHeader(title: 'Notifications & Alerts', subtitle: 'Configure real-time property and tour alerts'),
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

            SecondaryButton(text: 'Sign Out', icon: Icons.logout, onPressed: () => context.go(RouteNames.auth)),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
