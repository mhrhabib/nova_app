import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/cubits/country_cubit.dart';
import '../bloc/activities_bloc.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivitiesBloc()..add(FetchActivitiesEvent()),
      child: const _ActivitiesScreenContent(),
    );
  }
}

class _ActivitiesScreenContent extends StatefulWidget {
  const _ActivitiesScreenContent();

  @override
  State<_ActivitiesScreenContent> createState() => _ActivitiesScreenContentState();
}

class _ActivitiesScreenContentState extends State<_ActivitiesScreenContent> {
  int _selectedDayOffset = 0;

  void _showBookingSheet(BuildContext context) {
    final theme = Theme.of(context);
    final currentCountry = context.read<CountryCubit>().state;
    String selectedVisitType = 'Property Tour';
    String selectedHub = currentCountry.officeCity;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Schedule Visit & Concierge',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Module 10: Appointment & VIP Booking Engine',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Visit & Service Type',
                  style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Property Tour',
                    'Office Appointment',
                    'Virtual Meeting',
                    'VIP Airport Pickup',
                    'VIP Lounge Access',
                  ].map((type) {
                    final isSelected = selectedVisitType == type;
                    return ChoiceChip(
                      label: Text(type),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setModalState(() {
                            selectedVisitType = type;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Operating Regional Hub',
                  style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: selectedHub,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    'Dubai Marina & Downtown (UAE)',
                    'Gulshan-2, Dhaka (Bangladesh)',
                    'Mayfair, London (UK)',
                    'Manhattan, New York (USA)',
                  ].map((hub) => DropdownMenuItem(value: hub.split(' (').first, child: Text(hub))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setModalState(() {
                        selectedHub = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Confirm & Schedule Request',
                  icon: Icons.calendar_today,
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Confirmed: $selectedVisitType at $selectedHub. Assigned to regional concierge.',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentCountry = context.watch<CountryCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule & Activities'),
        actions: [
          IconButton(
            tooltip: 'Book Appointment',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => _showBookingSheet(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBookingSheet(context),
        icon: const Icon(Icons.calendar_month),
        label: const Text('Book Visit / Concierge'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Day Selector
            SectionHeader(
              title: 'September 2026',
              subtitle: 'Select date to view schedule in ${currentCountry.name}',
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 85,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 14,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedDayOffset;
                  final dayNumber = 7 + index;
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  final dayName = days[index % 7];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayOffset = index;
                      });
                    },
                    child: Container(
                      width: 65,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dayName,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: isSelected ? Colors.white70 : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$dayNumber',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // Activity Agenda Timeline
            SectionHeader(
              title: 'Agenda Timeline',
              subtitle: 'Upcoming tours, meetings, VIP visits & tasks',
              actionText: '+ New Visit',
              onActionTap: () => _showBookingSheet(context),
            ),
            const SizedBox(height: 12),

            BlocBuilder<ActivitiesBloc, ActivitiesState>(
              builder: (context, state) {
                if (state is ActivitiesLoading || state is ActivitiesInitial) {
                  return Column(
                    children: const [
                      LoadingShimmer(width: double.infinity, height: 80),
                      SizedBox(height: 12),
                      LoadingShimmer(width: double.infinity, height: 80),
                    ],
                  );
                }

                if (state is ActivitiesLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.activities.length,
                    itemBuilder: (context, index) {
                      final item = state.activities[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Checkbox(
                                value: item.isCompleted,
                                activeColor: theme.colorScheme.primary,
                                onChanged: (_) {
                                  context.read<ActivitiesBloc>().add(ToggleTaskCompletedEvent(item.id));
                                },
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        StatusBadge(
                                          text: item.type,
                                          type: item.type == 'Tour'
                                              ? StatusBadgeType.success
                                              : (item.type == 'Task' ? StatusBadgeType.warning : StatusBadgeType.info),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          item.time,
                                          style: theme.textTheme.labelMedium?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.title,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined, size: 14, color: theme.colorScheme.onSurfaceVariant),
                                        const SizedBox(width: 4),
                                        Text(item.location, style: theme.textTheme.bodySmall),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
