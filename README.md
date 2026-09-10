# Nova — Digital Business Operating System (NDBOS) Mobile & Web Client

**Nova** is the client-facing cross-platform mobile and web application powering the **Nova Development Digital Business Operating System (NDBOS v1.0)**. Built with Flutter, BLoC state management, GoRouter declarative routing, GetIt dependency injection, and an adaptive design system.

> 📄 **Official Specification**: See [PROJECT_REQUIREMENTS.md](file:///Users/becps21/bec_app/nova_app/PROJECT_REQUIREMENTS.md) for the complete Business Requirements Specification (BRS v1.0) covering all 24 enterprise functional modules, multi-country architecture, and roadmap.

---

## 🌐 Multi-Country Real Estate Coverage

The application dynamically adapts to Nova Development's four international operating markets:
- 🇦🇪 **United Arab Emirates (UAE)** — `AED` (د.إ)
- 🇧🇩 **Bangladesh** — `BDT` (৳)
- 🇬🇧 **United Kingdom (UK)** — `GBP` (£)
- 🇺🇸 **United States of America (USA)** — `USD` ($)

Features include real-time localized currency formatting, international dial codes, country project feeds, and regional sales office directories.

---

## 🏗️ Architecture & Layering

The codebase follows a **Feature-First Architecture** aligned with NDBOS modules:

```
lib/
  core/
    theme/          -> AppColors, AppTypography, AppTheme, ThemeCubit
    constants/       -> AppBreakpoints, AppSpacing, AppRadii, AppDurations, AppCountries
    routing/         -> GoRouter configuration, AppNavShell (Adaptive Nav), RouteNames
    widgets/         -> Reusable UI components (PropertyCard, Buttons, Inputs, Shimmers, CountryPicker)
    utils/           -> Responsive helper, CurrencyFormatter & BuildContext extensions
    di/              -> GetIt service locator setup
  features/
    auth/            -> Login, OTP Verification, Profile Setup (Module 01)
    home/            -> Search Header, Multi-Country Carousel, Categories, Recommendations (Module 05 & 22)
    search/          -> Interactive Search, Country Filter, Radius Slider, Map Pins (Module 06 & 22)
    properties/      -> Grid/List View Toggle, Multi-Currency Pricing, Filter Chips (Module 06)
    property_detail/ -> Dynamic Gallery, 3D Tours, Floor Plan, Agent Cards, CTAs (Module 06)
    lead_matching/   -> AI Buyer/Renter Match Feed & Score Badges (Module 08 & 24)
    activities/      -> Calendar View, Tasks with Checkboxes, Site Tour Schedule (Module 10)
    communication/   -> Agent Directory & Quick Actions (Call, WhatsApp, Email) (Module 08)
    dashboard/       -> KPI Summary Cards & Bookmarked Properties Quick View (Module 14 & 22)
    notifications/   -> Read/Unread Notifications & Deep-Link Navigation (Module 21)
    profile/         -> Customer Lifecycle Tier (Guest to VIP), Theme Switcher, Digital Pass (Module 09 & 22)
  main.dart
```

---

## 🎨 Theming System (Light & Dark)

- **Single Source Color Tokens**: Defined in [`AppColors`](file:///Users/becps21/bec_app/nova_app/lib/core/theme/app_colors.dart). No hardcoded hex colors exist within feature screen widgets.
- **Dynamic Theme Mode Persistence**: Controlled via `ThemeCubit` and persisted across sessions using `shared_preferences`.
- **System Default & Manual Toggle**: Accessible on the **Profile / Settings** screen (`System`, `Light`, `Dark`).

---

## 📱 Responsive Layout Engine

Breakpoints defined in [`AppBreakpoints`](file:///Users/becps21/bec_app/nova_app/lib/core/constants/app_breakpoints.dart):
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

# Start application
flutter run
```

