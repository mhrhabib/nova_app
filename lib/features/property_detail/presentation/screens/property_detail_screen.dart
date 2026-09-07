import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../bloc/property_detail_bloc.dart';

class PropertyDetailScreen extends StatelessWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyDetailBloc()..add(FetchPropertyDetailEvent(propertyId)),
      child: const _PropertyDetailScreenContent(),
    );
  }
}

class _PropertyDetailScreenContent extends StatefulWidget {
  const _PropertyDetailScreenContent();

  @override
  State<_PropertyDetailScreenContent> createState() => _PropertyDetailScreenContentState();
}

class _PropertyDetailScreenContentState extends State<_PropertyDetailScreenContent> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<PropertyDetailBloc, PropertyDetailState>(
      listener: (context, state) {
        if (state is PropertyDetailLoaded) {
          if (state.visitScheduled) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tour visit scheduled successfully!'), backgroundColor: AppColors.success),
            );
          }
          if (state.inquirySubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Inquiry sent to listing agent.'), backgroundColor: AppColors.success),
            );
          }
        }
      },
      builder: (context, state) {
        if (state is PropertyDetailLoading || state is PropertyDetailInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is PropertyDetailError) {
          return Scaffold(
            appBar: AppBar(),
            body: ErrorStateView(
              errorMessage: state.message,
              onRetry: () {},
            ),
          );
        }

        if (state is PropertyDetailLoaded) {
          final prop = state.property;

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                // Custom App Bar with Image Carousel
                SliverAppBar(
                  expandedHeight: 320,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        PageView.builder(
                          itemCount: prop.galleryUrls.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: prop.galleryUrls[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '${_currentImageIndex + 1} / ${prop.galleryUrls.length}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatusBadge(text: prop.tag, type: StatusBadgeType.info),
                            Text(
                              prop.price,
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          prop.title,
                          style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: theme.colorScheme.onSurfaceVariant, size: 18),
                            const SizedBox(width: 4),
                            Text(prop.location, style: theme.textTheme.bodyLarge),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Key Facts Grid
                        Text('Key Specs & Facts', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildFactTile(context, Icons.bed_outlined, '${prop.bedrooms}', 'Bedrooms'),
                            _buildFactTile(context, Icons.bathtub_outlined, '${prop.bathrooms}', 'Bathrooms'),
                            _buildFactTile(context, Icons.square_foot_outlined, '${prop.areaSqft.toInt()}', 'SqFt'),
                            _buildFactTile(context, Icons.corporate_fare_outlined, prop.propertyType, 'Type'),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Description
                        Text('Overview', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          prop.description,
                          style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                        ),

                        const SizedBox(height: 28),

                        // Floor Plan Preview
                        Text('Floor Plan', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.colorScheme.outline),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.architecture, size: 48, color: theme.colorScheme.primary),
                              const SizedBox(height: 8),
                              Text('Architectural Blueprint & 3D Tour', style: theme.textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text('Tap to launch 360 interactive walkthrough', style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Agent & Agency Card
                        Text('Listing Agent', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(prop.agentImage),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(prop.agentName, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                                      Text(prop.agencyName, style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                                  child: IconButton(
                                    icon: Icon(Icons.phone, color: theme.colorScheme.primary),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 100), // Bottom padding for sticky CTAs
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomSheet: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: 'Schedule Visit',
                      icon: Icons.calendar_month,
                      onPressed: () => _showScheduleVisitModal(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Inquire Now',
                      icon: Icons.chat_bubble_outline,
                      onPressed: () {
                        context.read<PropertyDetailBloc>().add(const SubmitInquiryEvent('Is this property available?'));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFactTile(BuildContext context, IconData icon, String value, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: theme.colorScheme.primary),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  void _showScheduleVisitModal(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (modalContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Schedule Private Tour', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Select your preferred slot with ${context.read<PropertyDetailBloc>().state is PropertyDetailLoaded ? (context.read<PropertyDetailBloc>().state as PropertyDetailLoaded).property.agentName : "agent"}.', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: ChoiceChip(label: const Text('Tomorrow 10:00 AM'), selected: true, onSelected: (_) {})),
                const SizedBox(width: 8),
                Expanded(child: ChoiceChip(label: const Text('Tomorrow 02:30 PM'), selected: false, onSelected: (_) {})),
              ],
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Confirm Tour Schedule',
              onPressed: () {
                context.read<PropertyDetailBloc>().add(ScheduleVisitEvent(date: DateTime.now().add(const Duration(days: 1)), timeSlot: '10:00 AM'));
                Navigator.pop(modalContext);
              },
            ),
          ],
        ),
      ),
    );
  }
}
