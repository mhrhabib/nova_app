import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/loading_shimmer.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule & Activities'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Day Selector
            SectionHeader(title: 'September 2026', subtitle: 'Select date to view schedule'),
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
                          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline.withOpacity(0.3),
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
            SectionHeader(title: 'Agenda Timeline', subtitle: 'Upcoming tours, tasks, and follow-ups'),
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
          ],
        ),
      ),
    );
  }
}
