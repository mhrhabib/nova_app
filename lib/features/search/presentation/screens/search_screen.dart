import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/property_card.dart';
import '../../../../core/widgets/filter_chip_group.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/routing/route_names.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()..add(const SearchQueryChangedEvent('')),
      child: const _SearchScreenContent(),
    );
  }
}

class _SearchScreenContent extends StatefulWidget {
  const _SearchScreenContent();

  @override
  State<_SearchScreenContent> createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<_SearchScreenContent> {
  bool _showMap = false;
  double _radius = 10.0;
  double _maxPrice = 3000000;
  String _selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Property Search'),
        actions: [
          IconButton(
            icon: Icon(_showMap ? Icons.view_list : Icons.map_outlined),
            onPressed: () {
              setState(() {
                _showMap = !_showMap;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AppTextField(
                  label: '',
                  hintText: 'Try "3 Bed Penthouse in Waterfront under \$2.5M"',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.mic_none),
                    onPressed: () {},
                  ),
                  onChanged: (val) {
                    context.read<SearchBloc>().add(SearchQueryChangedEvent(val));
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('Radius: ${_radius.toInt()} km', style: theme.textTheme.labelMedium),
                    Expanded(
                      child: Slider(
                        value: _radius,
                        min: 1,
                        max: 50,
                        divisions: 49,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (val) {
                          setState(() {
                            _radius = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _showMap
                ? _buildMapView(context)
                : BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoadingState) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: 4,
                          itemBuilder: (context, index) => LoadingShimmer.propertyCardShimmer(context, isList: true),
                        );
                      }

                      if (state is SearchLoadedState) {
                        if (state.results.isEmpty) {
                          return const EmptyStateView(
                            title: 'No properties found',
                            description: 'Try adjusting your search query or radius filters.',
                          );
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isDesktop ? 1.05 : (isTablet ? 0.95 : 0.88),
                          ),
                          itemCount: state.results.length,
                          itemBuilder: (context, index) {
                            final item = state.results[index];
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

  Widget _buildMapView(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 80, color: theme.colorScheme.primary.withOpacity(0.4)),
                const SizedBox(height: 12),
                Text(
                  'Interactive Map View',
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Showing properties within ${_radius.toInt()} km radius around Metro City Waterfront',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 60,
            child: _buildMapPin(context, '\$2.45M', true),
          ),
          Positioned(
            top: 140,
            right: 80,
            child: _buildMapPin(context, '\$1.89M', false),
          ),
          Positioned(
            bottom: 120,
            left: 120,
            child: _buildMapPin(context, '\$6.5k/mo', false),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(BuildContext context, String price, bool isSelected) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Text(
        price,
        style: TextStyle(
          color: isSelected ? Colors.white : theme.colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search Filters', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 16),
              Text('Property Type', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              FilterChipGroup<String>(
                options: const ['All', 'Villa', 'Penthouse', 'Apartment', 'House'],
                selectedOption: _selectedType,
                labelBuilder: (o) => o,
                onSelected: (val) => setModalState(() => _selectedType = val),
              ),
              const SizedBox(height: 20),
              Text('Max Price: \$${(_maxPrice / 1000).toInt()}k', style: theme.textTheme.titleMedium),
              Slider(
                value: _maxPrice,
                min: 500000,
                max: 10000000,
                divisions: 19,
                onChanged: (val) => setModalState(() => _maxPrice = val),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<SearchBloc>().add(FilterUpdatedEvent(
                          maxPrice: _maxPrice,
                          propertyType: _selectedType,
                          bedrooms: 0,
                          radiusKm: _radius,
                        ));
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
