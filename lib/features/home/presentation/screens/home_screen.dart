import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/property_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/filter_chip_group.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../../../core/widgets/country_selector_sheet.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/cubits/country_cubit.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchHomeDataEvent()),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;
    final currentCountry = context.watch<CountryCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => CountrySelectorSheet.show(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  currentCountry.flag,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Operating Hub',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          currentCountry.currencyCode,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        currentCountry.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Switch Country',
            icon: const Icon(Icons.public),
            onPressed: () => CountrySelectorSheet.show(context),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => context.go(RouteNames.notifications),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(FetchHomeDataEvent());
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input Trigger
              GestureDetector(
                onTap: () => context.go(RouteNames.search),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: theme.colorScheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Search ${currentCountry.shortName} developments, penthouses...',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.tune, size: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Regional Banner Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'NOVA GLOBAL EXPANSION',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Explore ${currentCountry.name} Portfolio',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Direct developer pricing in ${currentCountry.currencyCode} (${currentCountry.currencySymbol}). Office: ${currentCountry.officeCity}.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      currentCountry.flag,
                      style: const TextStyle(fontSize: 42),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LoadingShimmer(width: 180, height: 24),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) => Container(
                              width: 300,
                              margin: const EdgeInsets.only(right: 16),
                              child: LoadingShimmer.propertyCardShimmer(context),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is HomeError) {
                    return ErrorStateView(
                      errorMessage: state.message,
                      onRetry: () => context.read<HomeBloc>().add(FetchHomeDataEvent()),
                    );
                  }

                  if (state is HomeLoaded) {
                    // Filter or prioritize properties matching the current country
                    final countryProperties = state.featuredProperties
                        .where((p) => p.countryCode == currentCountry.code)
                        .toList();
                    final displayFeatured = countryProperties.isNotEmpty
                        ? countryProperties
                        : state.featuredProperties;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Featured Section
                        SectionHeader(
                          title: '${currentCountry.shortName} Premier Collection',
                          subtitle: 'Handpicked developments in ${currentCountry.name}',
                          actionText: 'View All',
                          onActionTap: () => context.go(RouteNames.properties),
                        ),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: displayFeatured.length,
                            itemBuilder: (context, index) {
                              final item = displayFeatured[index];
                              return Container(
                                width: isDesktop ? 380 : 300,
                                margin: const EdgeInsets.only(right: 16),
                                child: PropertyCard(
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
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Filter Categories
                        FilterChipGroup<String>(
                          options: const ['All', 'Villa', 'Penthouse', 'Apartment', 'House'],
                          selectedOption: _selectedCategory,
                          labelBuilder: (option) => option,
                          onSelected: (category) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        ),

                        const SizedBox(height: 24),

                        // Recommended Grid / List
                        SectionHeader(
                          title: 'Global High-Yield Portfolio',
                          subtitle: 'Multi-country prime projects (UAE, BD, UK, USA)',
                        ),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isDesktop ? 1.1 : (isTablet ? 0.9 : 0.78),
                          ),
                          itemCount: state.recommendedProperties.length,
                          itemBuilder: (context, index) {
                            final item = state.recommendedProperties[index];
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
                              isSaved: item.isSaved,
                              onTap: () => context.go('${RouteNames.propertyDetail}/${item.id}'),
                            );
                          },
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
