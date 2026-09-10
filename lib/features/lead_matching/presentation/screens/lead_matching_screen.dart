import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/property_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/routing/route_names.dart';
import '../bloc/lead_matching_bloc.dart';

class LeadMatchingScreen extends StatelessWidget {
  const LeadMatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadMatchingBloc()..add(FetchLeadMatchesEvent()),
      child: const _LeadMatchingScreenContent(),
    );
  }
}

class _LeadMatchingScreenContent extends StatelessWidget {
  const _LeadMatchingScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Lead & Property Match Feed'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.8)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, size: 36, color: Colors.white),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nova Match Intelligence',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Matches curated based on your target budget, desired amenities, and saved searches.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<LeadMatchingBloc, LeadMatchingState>(
              builder: (context, state) {
                if (state is LeadMatchingLoading || state is LeadMatchingInitial) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 3,
                    itemBuilder: (context, index) => LoadingShimmer.propertyCardShimmer(context),
                  );
                }

                if (state is LeadMatchingLoaded) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isDesktop ? 1.0 : (isTablet ? 0.92 : 0.84),
                    ),
                    itemCount: state.matchedProperties.length,
                    itemBuilder: (context, index) {
                      final item = state.matchedProperties[index];
                      return Stack(
                        children: [
                          PropertyCard(
                            id: item.id,
                            title: item.title,
                            price: item.price,
                            location: item.location,
                            bedrooms: item.bedrooms,
                            bathrooms: item.bathrooms,
                            areaSqft: item.areaSqft,
                            imageUrl: item.imageUrl,
                            tag: item.tag,
                            isSaved: item.isSaved,
                            onTap: () => context.go('${RouteNames.propertyDetail}/${item.id}'),
                          ),
                          Positioned(
                            top: 10,
                            right: 54,
                            child: StatusBadge(
                              text: '${item.matchScore}% Match',
                              type: StatusBadgeType.success,
                              icon: Icons.bolt,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
