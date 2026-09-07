# Nova — Real Estate Cross-Platform App

**Nova** is a production-grade, client-facing real-estate mobile and web application built with Flutter, BLoC state management, GoRouter declarative routing, GetIt dependency injection, and a single source-of-truth design system.

---

## 🏗️ Architecture & Layering

The codebase follows a **Feature-First Architecture**:

```
lib/
  core/
    theme/          -> AppColors, AppTypography, AppTheme, ThemeCubit
    constants/       -> AppBreakpoints, AppSpacing, AppRadii, AppDurations
    routing/         -> GoRouter configuration, AppNavShell (Adaptive Nav), RouteNames
    widgets/         -> Reusable UI components (PropertyCard, Buttons, Inputs, Shimmers)
    utils/           -> Responsive helper & BuildContext extensions
    di/              -> GetIt service locator setup
  features/
    auth/            -> Login, OTP Verification, Profile Setup (AuthBloc)
    home/            -> Search Header, Featured Carousel, Categories, Recommendations (HomeBloc)
    search/          -> Interactive Search, Radius Slider, Map View Pins, Filters Modal (SearchBloc)
    properties/      -> Grid/List View Toggle, Sorting, Filter Chips (PropertiesBloc)
    property_detail/ -> Dynamic Gallery, Key Facts, Floor Plan, Agent Cards, CTAs (PropertyDetailBloc)
    lead_matching/   -> AI Buyer/Renter Match Feed & Score Badges (LeadMatchingBloc)
    activities/      -> Calendar View, Tasks with Checkboxes, Tour Schedule (ActivitiesBloc)
    communication/   -> Agent Directory & Quick Actions (Call, WhatsApp, Email) (CommunicationBloc)
    dashboard/       -> KPI Summary Cards & Bookmarked Properties Quick View (DashboardBloc)
    notifications/   -> Read/Unread Notifications & Deep-Link Navigation (NotificationsBloc)
    profile/         -> Profile Details, Theme Mode Switcher, Preferences (ProfileBloc)
  main.dart
```

---

## 🎨 Theming System (Light & Dark)

- **Single Source Color Tokens**: Defined in [`AppColors`](file:///Users/mhrhabib/nova%20development/nova_app/lib/core/theme/app_colors.dart). No hardcoded hex colors exist within feature screen widgets.
- **Dynamic Theme Mode Persistence**: Controlled via `ThemeCubit` and persisted across sessions using `shared_preferences`.
- **System Default & Manual Toggle**: Accessible on the **Profile / Settings** screen (`System`, `Light`, `Dark`).

---

## 📱 Responsive Layout Engine

Breakpoints defined in [`AppBreakpoints`](file:///Users/mhrhabib/nova%20development/nova_app/lib/core/constants/app_breakpoints.dart):
- **Mobile** (`width < 600`): Bottom navigation bar (`NavigationBar`), single-column feeds.
- **Tablet** (`600 <= width <= 1024`): Persistent side navigation rail (`NavigationRail`), 2-column grid cards, side sheets.
- **Desktop / Web** (`width > 1024`): Persistent side navigation rail (`NavigationRail`), 3-column grid cards.

---

## 🛠️ Getting Started

### Prerequisites
- Flutter SDK (>=3.12.2)
- Dart SDK

### Installation & Run
```bash
# Get packages
flutter pub get

# Run analysis
flutter analyze

# Run unit & widget tests
flutter test

# Start application
flutter run
```
