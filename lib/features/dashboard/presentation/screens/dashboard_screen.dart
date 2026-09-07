import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/property_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/routing/route_names.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(FetchDashboardDataEvent()),
      child: const _DashboardScreenContent(),
    );
  }
}

class _DashboardScreenContent extends StatelessWidget {
  const _DashboardScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Summary Cards
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoading || state is DashboardInitial) {
                  return Row(
                    children: const [
                      Expanded(child: LoadingShimmer(width: double.infinity, height: 90)),
                      SizedBox(width: 12),
                      Expanded(child: LoadingShimmer(width: double.infinity, height: 90)),
                      SizedBox(width: 12),
                      Expanded(child: LoadingShimmer(width: double.infinity, height: 90)),
                    ],
                  );
                }

                if (state is DashboardLoaded) {
                  return Row(
                    children: [
                      Expanded(child: _buildKPICard(context, 'Saved', '${state.savedCount}', Icons.bookmark_outline, theme.colorScheme.primary)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildKPICard(context, 'Visits', '${state.upcomingVisits}', Icons.calendar_today, Colors.orange)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildKPICard(context, 'Inquiries', '${state.activeInquiries}', Icons.chat_outlined, Colors.green)),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 28),

            // Saved Properties Quick View
            SectionHeader(
              title: 'Saved Properties',
              subtitle: 'Properties bookmarked for rapid comparison',
              actionText: 'View All',
              onActionTap: () => context.go(RouteNames.properties),
            ),
            const SizedBox(height: 8),

            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.savedProperties.length,
                    itemBuilder: (context, index) {
                      final item = state.savedProperties[index];
                      return PropertyCard(
                        id: item.id,
                        title: item.title,
                        price: item.price,
                        location: item.location,
                        bedrooms: item.bedrooms,
                        bathrooms: item.bathrooms,
                        areaSqft: item.areaSqft,
                        imageUrl: item.imageUrl,
                        tag: item.tag,
                        variant: PropertyCardVariant.list,
                        isSaved: true,
                        onTap: () => context.go('${RouteNames.propertyDetail}/${item.id}'),
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

  Widget _buildKPICard(BuildContext context, String label, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: 8),
            Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
