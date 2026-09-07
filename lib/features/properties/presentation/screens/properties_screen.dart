import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/property_card.dart';
import '../../../../core/widgets/filter_chip_group.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/routing/route_names.dart';
import '../bloc/properties_bloc.dart';

class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertiesBloc()..add(FetchPropertiesEvent()),
      child: const _PropertiesScreenContent(),
    );
  }
}

class _PropertiesScreenContent extends StatefulWidget {
  const _PropertiesScreenContent();

  @override
  State<_PropertiesScreenContent> createState() => _PropertiesScreenContentState();
}

class _PropertiesScreenContentState extends State<_PropertiesScreenContent> {
  String _selectedFilter = 'All Listings';

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Listings'),
        actions: [
          BlocBuilder<PropertiesBloc, PropertiesState>(
            builder: (context, state) {
              final isList = state is PropertiesLoaded && state.viewMode == PropertyCardVariant.list;
              return IconButton(
                icon: Icon(isList ? Icons.grid_view : Icons.view_list),
                onPressed: () {
                  context.read<PropertiesBloc>().add(ToggleViewModeEvent());
                },
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (val) {
              context.read<PropertiesBloc>().add(SortPropertiesEvent(val));
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'Newest', child: Text('Newest First')),
              PopupMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
              PopupMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FilterChipGroup<String>(
              options: const ['All Listings', 'Buy', 'Rent', 'Luxury Enclave', 'New Launch'],
              selectedOption: _selectedFilter,
              labelBuilder: (o) => o,
              onSelected: (val) => setState(() => _selectedFilter = val),
            ),
          ),
          Expanded(
            child: BlocBuilder<PropertiesBloc, PropertiesState>(
              builder: (context, state) {
                if (state is PropertiesLoading || state is PropertiesInitial) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 4,
                    itemBuilder: (context, index) => LoadingShimmer.propertyCardShimmer(context),
                  );
                }

                if (state is PropertiesLoaded) {
                  final isList = state.viewMode == PropertyCardVariant.list;

                  if (isList) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.properties.length,
                      itemBuilder: (context, index) {
                        final item = state.properties[index];
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
                          isSaved: item.isSaved,
                          onTap: () => context.go('${RouteNames.propertyDetail}/${item.id}'),
                        );
                      },
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
                    itemCount: state.properties.length,
                    itemBuilder: (context, index) {
                      final item = state.properties[index];
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
                        variant: PropertyCardVariant.grid,
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
}
