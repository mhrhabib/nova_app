import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/routing/route_names.dart';
import '../bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = context.isDesktop;

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              if (isDesktop)
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryBlue, Color(0xFF072659)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.apartment, size: 40, color: AppColors.primaryBlue),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Welcome to Nova',
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your premier gateway to luxury residential properties, real-time market data, and AI-powered match intelligence.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                flex: isDesktop ? 6 : 12,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message), backgroundColor: theme.colorScheme.error),
                            );
                          } else if (state is AuthAuthenticated) {
                            context.go(RouteNames.home);
                          }
                        },
                        builder: (context, state) {
                          if (state is OTPSentState) {
                            return _buildOTPForm(context, state.phoneNumber);
                          } else if (state is AuthNeedsProfileSetup) {
                            return _buildProfileSetupForm(context);
                          }
                          return _buildPhoneLoginForm(context, state is AuthLoading);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneLoginForm(BuildContext context, bool isLoading) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign In / Register',
          style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your mobile number to receive a verification code.',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 28),
        AppTextField(
          label: 'Mobile Number',
          hintText: '+1 (555) 000-0000',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          text: 'Send Verification Code',
          isLoading: isLoading,
          onPressed: () {
            context.read<AuthBloc>().add(SendOTPEvent(_phoneController.text.trim()));
          },
        ),
        const SizedBox(height: 16),
        SecondaryButton(
          text: 'Explore as Guest',
          onPressed: () => context.go(RouteNames.home),
        ),
      ],
    );
  }

  Widget _buildOTPForm(BuildContext context, String phone) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Code',
          style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a 6-digit verification code to $phone. (Demo Code: 123456)',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 28),
        AppTextField(
          label: '6-Digit Code',
          hintText: '123456',
          controller: _otpController,
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.lock_outline),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          text: 'Verify & Continue',
          onPressed: () {
            context.read<AuthBloc>().add(VerifyOTPEvent(_otpController.text.trim()));
          },
        ),
      ],
    );
  }

  Widget _buildProfileSetupForm(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Complete Profile',
          style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Tell us a bit about yourself to personalize your property search.',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 24),
        AppTextField(
          label: 'Full Name',
          hintText: 'Alexander Wright',
          controller: _nameController,
          prefixIcon: const Icon(Icons.person_outline),
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: 'Email Address',
          hintText: 'alexander@example.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          text: 'Get Started',
          onPressed: () {
            context.read<AuthBloc>().add(CompleteProfileEvent(
                  fullName: _nameController.text.isEmpty ? 'Alex Wright' : _nameController.text,
                  email: _emailController.text.isEmpty ? 'alex@nova.com' : _emailController.text,
                ));
          },
        ),
      ],
    );
  }
}
