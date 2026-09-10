import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/icon_text_button.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../bloc/communication_bloc.dart';

class CommunicationScreen extends StatelessWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunicationBloc()..add(FetchContactsEvent()),
      child: const _CommunicationScreenContent(),
    );
  }
}

class _CommunicationScreenContent extends StatelessWidget {
  const _CommunicationScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Directory & Contact'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Assigned Real-Estate Advisors',
              subtitle: 'Direct contact for property inquiries and virtual tours',
            ),
            const SizedBox(height: 12),
            BlocBuilder<CommunicationBloc, CommunicationState>(
              builder: (context, state) {
                if (state is CommunicationLoading || state is CommunicationInitial) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: LoadingShimmer(width: double.infinity, height: 100),
                    ),
                  );
                }

                if (state is CommunicationLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = state.contacts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(contact.avatarUrl),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contact.name,
                                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(contact.title, style: theme.textTheme.bodySmall),
                                        Text(contact.agency, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Divider(height: 1, color: theme.colorScheme.outline.withValues(alpha: 0.5)),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconTextButton(
                                    icon: Icons.phone,
                                    label: 'Call',
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Dialing ${contact.phone}...')),
                                      );
                                    },
                                  ),
                                  IconTextButton(
                                    icon: Icons.chat_outlined,
                                    label: 'WhatsApp',
                                    color: const Color(0xFF25D366),
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Opening WhatsApp with ${contact.name}...')),
                                      );
                                    },
                                  ),
                                  IconTextButton(
                                    icon: Icons.email_outlined,
                                    label: 'Email',
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Opening Email app for ${contact.email}...')),
                                      );
                                    },
                                  ),
                                ],
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
