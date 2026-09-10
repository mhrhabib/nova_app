# Business Requirements Specification (BRS)
## Nova Development Digital Business Operating System (NDBOS)
**Version:** 1.0  
**Status:** Approved Specification  
**Prepared For:** Nova Development  
**Prepared By:** Mohammad Saiful Islam  

---

## 1. Executive Summary

**Nova Development** is a premier multinational real estate and property development company with active operations across four key international markets:
- 🇦🇪 **United Arab Emirates (UAE)** — Dubai / Abu Dhabi
- 🇧🇩 **Bangladesh** — Dhaka / Chittagong
- 🇬🇧 **United Kingdom (UK)** — London
- 🇺🇸 **United States of America (USA)** — New York / Florida

The objective of the **Nova Development Digital Business Operating System (NDBOS)** is to deliver an enterprise-grade, cloud-native, centralized digital ecosystem governing:
1. **Global Corporate Website** (`novadevelopmentglobal.com`)
2. **Country-Specific Portals** (`.com.bd`, `.ae`, `.uk`, `.us`)
3. **CRM & Multi-Channel Lead Management**
4. **Marketing Operations & Attribution Engine**
5. **Customer Mobile Application** (iOS & Android via Flutter)
6. **HR & Multi-Country Payroll**
7. **Enterprise Analytics & Business Intelligence**
8. **AI-Powered Services** (Automated Lead Scoring, Content, & SEO)

### Architectural Tenets
- 📱 **Mobile Friendly**: Adaptive interfaces optimized across handhelds, tablets, and desktop viewports.
- 🎯 **Marketing Focused**: Full funnel attribution across Meta, Google, TikTok, LinkedIn, and WhatsApp.
- 🔍 **SEO Optimized**: Country-specific hreflang, schema metadata, dynamic sitemaps, and canonical routing.
- ⚡ **API First**: Headless REST API gateway facilitating seamless multi-platform connectivity.
- ☁️ **Cloud Native**: Scalable, high-availability infrastructure hosted on Microsoft Azure & Cloudflare.
- 🔒 **Secure**: Strict OWASP Top 10 compliance, encrypted data storage, audit trails, and granular RBAC.
- 🌐 **Multi-Country & Multi-Currency**: Native localization for AED, BDT, GBP, and USD.
- 📈 **Scalable**: Zero-rebuild expansion capability for upcoming jurisdictions (Saudi Arabia, Canada, Qatar, Australia).

---

## 2. Business Objectives

| Objective | Description | Target Metric |
| :--- | :--- | :--- |
| **Digital Branding** | Establish Nova Development as a luxury, globally recognized real estate developer. | Unified brand identity across 5 web domains and mobile applications. |
| **Lead Generation** | Capture, enrich, and convert high-intent prospective buyers, investors, and partners. | Multi-touch attribution with automated sales rep routing. |
| **Customer Engagement** | Deliver personalized property portfolios, 3D tours, and VIP client perks. | High app retention, instant appointment scheduling, and digital buyer pass. |
| **Operational Efficiency** | Unify CMS, CRM, HR, Payroll, and Document Management across 4 global branches. | 100% centralized data store eliminating cross-country silos. |
| **Data-Driven Intelligence** | Provide C-suite executives with real-time sales pipeline velocity and ROI metrics. | Real-time executive dashboards with AI-driven market forecasting. |

---

## 3. Project Scope

### Web Portals
- **Global Corporate Portal**: [novadevelopmentglobal.com](https://novadevelopmentglobal.com)
- **Bangladesh Portal**: [novadevelopment.com.bd](https://novadevelopment.com.bd)
- **UAE Portal**: [novadevelopment.ae](https://novadevelopment.ae)
- **UK Portal**: [novadevelopment.uk](https://novadevelopment.uk)
- **USA Portal**: [novadevelopment.us](https://novadevelopment.us)

### Cross-Platform Mobile Application
- **Platform**: Flutter (iOS & Android)
- **Target Audiences**: Guests, Registered Prospects, Property Buyers, Property Owners, and VIP Investors.

### Core Back-Office & Business Engines
- Headless API Gateway
- Content Management System (CMS)
- Customer Relationship Management (CRM)
- Marketing Operations & Campaign Tracking
- Human Resources Management & Country-Specific Payroll
- Analytics, Business Intelligence & Phase 2 AI Services

---

## 4. Business Architecture

```
Nova Development (NDBOS)
├── Global Corporate Portal (novadevelopmentglobal.com)
├── Bangladesh Portal (novadevelopment.com.bd)
├── UAE Portal (novadevelopment.ae)
├── UK Portal (novadevelopment.uk)
├── USA Portal (novadevelopment.us)
├── Customer Mobile Application (Flutter iOS & Android)
├── Headless API Gateway (Laravel 12 Sanctum)
├── Centralized CRM (Lead Pipeline & Customer Lifecycle)
├── Content Management System (Global & Country Content)
├── HR & Country-Specific Payroll (BD, UAE, UK, USA)
├── Marketing & Attribution Engine (Meta, Google, TikTok, LinkedIn)
├── Analytics & Executive BI
└── AI Service Layer (Phase 2)
```

---

## 5. Functional Modules Specification

### Module 01: Authentication & Security
- Multi-factor authentication (MFA) via SMS OTP, WhatsApp OTP, and Authenticator apps.
- Secure Session Management, active device listing, and remote session revocation.
- Comprehensive login history with IP address, geo-location, user-agent, and access timestamps.
- Automated brute-force lockout and anomaly detection.

### Module 02: Access Control List (ACL)
**12 System Roles:**
1. `Super Admin` — Global administrative authority across all countries and modules.
2. `Corporate Admin` — Corporate portal, branding, and cross-country reporting.
3. `Country Admin` — Operational oversight restricted to assigned jurisdiction.
4. `Marketing Manager` — Campaigns, UTM parameters, lead attribution, and landing pages.
5. `SEO Manager` — Metadata, schema tags, canonical links, and sitemaps.
6. `Sales Manager` — Pipeline management, sales targets, and rep assignment.
7. `Sales Executive` — Lead follow-ups, meeting logs, and deal progression.
8. `HR Manager` — Personnel directory, attendance monitoring, and leave approvals.
9. `Payroll Manager` — Country-specific tax, deduction, and salary disbursements.
10. `Property Manager` — Project catalog, unit availability, pricing, and floor plans.
11. `Customer Support` — Tickets, inquiries, chat logs, and feedback management.
12. `Customer` — Mobile app user, saved favorites, bookings, and digital buyer pass.

**8 Core Permissions:**
1. `View` | 2. `Create` | 3. `Edit` | 4. `Delete` | 5. `Approve` | 6. `Publish` | 7. `Export` | 8. `Assign`

### Module 03: User Management
- Hierarchical user profiles with multi-country, branch, and department tagging.
- Comprehensive audit trails tracking all user actions, record changes, and exports.

### Module 04: Multi-Country Management
- Dynamic Country Setup with localized business rules and branding.
- Multi-Currency engine with automatic rate conversions:
  - 🇦🇪 UAE: `AED` (د.إ)
  - 🇧🇩 Bangladesh: `BDT` (৳)
  - 🇬🇧 UK: `GBP` (£)
  - 🇺🇸 USA: `USD` ($)
- Timezone handling and multi-lingual content readiness (English, Arabic, Bengali).

### Module 05: Content Management System (CMS)
- **Corporate Content**: Chairman Message, Vision & Mission, Corporate Story, Investor Relations, CSR initiatives, Press News.
- **Country Content**: Local market reports, localized project spotlights, country news, and localized landing pages.
- **Media Asset Library**: High-resolution photography, 4K architectural videos, downloadable PDF brochures, and architectural CAD/floorplans.

### Module 06: Property Management
- **Hierarchical Catalog**: Projects ➔ Properties ➔ Individual Units.
- **Unit Attributes**: Unit number, floor, square footage/meters, bedrooms/bathrooms, orientation, pricing, and real-time availability status (`Available`, `Reserved`, `Sold`).
- **Rich Media**: Interactive 3D virtual walkthroughs (Matterport/WebGL integration), dynamic image galleries, downloadable floor plans, and architectural specification sheets.

### Module 07: Blog & News Management
- Editorial workflow: Draft, Review, Schedule, Publish.
- Content taxonomies: Industry Trends, Construction Progress, Market Investment Reports, Press Releases.

### Module 08: CRM & Multi-Channel Lead Management
**Lead Sources:**
1. Website Form | 2. Facebook | 3. Instagram | 4. LinkedIn | 5. TikTok | 6. Google Ads | 7. WhatsApp | 8. Referral | 9. Manual Entry

**11-Stage Lead Pipeline:**
```
[1. New Lead] ➔ [2. Assigned] ➔ [3. Contacted] ➔ [4. Qualified] ➔ [5. Meeting] 
       ➔ [6. Visit Scheduled] ➔ [7. Proposal] ➔ [8. Negotiation] ➔ [9. Booked] ➔ [10. Sold]
                                                                        └── [11. Lost]
```
- Automated round-robin and performance-based sales rep lead distribution.
- Complete timeline tracking all phone calls, WhatsApp messages, emails, and notes.

### Module 09: Customer Management & Lifecycle Tiers
```
[1. Guest] ➔ [2. Registered User] ➔ [3. Cold Lead] ➔ [4. Warm Lead] ➔ [5. Hot Lead] 
       ➔ [6. Buyer] ➔ [7. Owner] ➔ [8. VIP Member]
```
- **VIP Member Tier**: Exclusive access to off-market penthouses, private lounge bookings, priority airport pickup, and dedicated investment advisors.

### Module 10: Appointment & Visit Management
- Multi-type scheduling:
  - 🏢 Office Appointment (Dubai, Dhaka, London, New York)
  - 🏗️ On-Site Property Tour / Inspection
  - 💻 Virtual Video Meeting (Zoom / Google Meet integration)
  - ✈️ Airport Pickup & Concierge Service (for international investors)
  - 🛋️ VIP Lounge Access Reservation

### Module 11: Feedback & Review Management
- Customer satisfaction (CSAT) and Net Promoter Score (NPS) surveys.
- Review moderation queue and verified buyer badge testimonials.

### Module 12: Marketing Management & Attribution
- Centralized Campaign Registry with real-time UTM parameter tracking.
- First-touch and multi-touch lead attribution across Meta Ads, Google Ads, LinkedIn Ads, TikTok Ads, Organic Search, and Direct Traffic.

### Module 13: SEO Management
- Dynamic XML sitemap generator, canonical URL management, and schema.org JSON-LD generation (`RealEstateListing`, `Organization`, `BreadcrumbList`).
- Multi-region `hreflang` management ensuring search engines direct users to their regional portal.

### Module 14: Analytics & Business Intelligence
- Native integrations: GA4, Google Tag Manager, Meta Pixel, LinkedIn Insight Tag, TikTok Pixel.
- Real-time executive dashboards: Visitor-to-Lead conversion rate, Cost per Acquisition (CPA), Pipeline value, and Return on Ad Spend (ROAS).

### Module 15: HR Management
- Digital employee profiles, organizational chart, department hierarchies, and document vaults.

### Module 16: Attendance Management
- Hardware integration: Biometric fingerprint readers, Face Recognition terminals, RFID cards, and manual supervisor entry.
- Shift management, overtime calculation, and late-entry tracking.

### Module 17: Leave Management
- Leave accruals, multi-tier manager approvals, balance statements, and localized country holiday calendars.

### Module 18: Country-Specific Payroll Management
- **Bangladesh (BD)**: Basic Salary, House Rent Allowance, Medical Allowance, Festival Bonuses (Eid), Conveyance, Tax Withholding.
- **United Arab Emirates (UAE)**: Basic Salary, Housing Allowance, Transport Allowance, End of Service Gratuity (WPS compliant).
- **United Kingdom (UK)**: Basic Salary, PAYE Income Tax calculation, National Insurance (NI) contributions, Pension auto-enrollment.
- **United States (USA)**: Federal/State/FICA tax compliance, 401(k) deductions, healthcare benefits.

### Module 19: Commission Management
- Transparent commission tier calculation for in-house sales executives, property managers, and external referral brokers upon deal closure (`Sold`).

### Module 20: Document Management System (DMS)
- Encrypted storage for KYC documents, passport copies, Sale & Purchase Agreements (SPA), floor plan deeds, and employee contracts.

### Module 21: Notification System
- Omnichannel delivery engine:
  - Email (Transactional via SendGrid/Mailgun)
  - SMS & WhatsApp (Twilio / Meta Cloud API)
  - Mobile Push Notifications (Firebase Cloud Messaging)
  - In-App Notification Center

### Module 22: Customer Mobile Application (Flutter)
- **Guest Experience**:
  - Global & localized country property browsing with high-resolution imagery.
  - Interactive search filters (Country, City, Price Range, Property Type, Bedrooms, Amenities).
  - Market insights and upcoming off-plan launch alerts.
- **Registered User Experience**:
  - Saved favorites and saved search alerts.
  - One-tap appointment booking (Site visit, Virtual tour, Office visit).
  - Push notifications on price adjustments and construction milestones.
- **Buyer & VIP Member Experience**:
  - **Digital ID & Pass**: Secure QR pass for fast-track office reception entry and VIP lounge access.
  - **My Properties Portfolio**: Construction updates, payment schedule tracking, and document downloads.
  - **VIP Concierge**: Direct WhatsApp hotline, airport pickup requests, and private event invitations.

### Module 23: API Gateway
- High-throughput REST API layer authenticated with Laravel Sanctum tokens.
- Secure endpoints serving web frontends, mobile applications, and third-party integrations with strict rate limiting.

### Module 24: AI Services (Phase 2)
- **AI Lead Scoring**: Real-time evaluation of lead intent (Cold, Warm, Hot) based on behavioral signals, budget, and response times.
- **AI Content Assistant**: Automated generation of localized property blurbs, SEO meta tags, and press releases.
- **AI SEO Assistant**: Automated internal linking recommendations and keyword gap analysis.
- **AI Executive Summary**: Monthly natural-language executive briefs analyzing sales velocity and cross-country ROI.

---

## 6. Deferred / Future Phase Modules

### Module 31: Visitor & Prospect Management System (VPMS)
> [!NOTE]
> **Status: DEFERRED FOR CURRENT ITERATION** (Per project steering direction).  
> The VPMS specification (including Reception Desk Touch Kiosks, OTP Walk-in verification, automated Walk-In lead generation, and offline-first check-in cache) remains documented in architectural blueprints for future release.

---

## 7. System & Technical Architecture

```
                       [ Internet Users / Mobile App ]
                                      │
                                      ▼
                             [ Cloudflare CDN / WAF ]
                                      │
                                      ▼
                        [ Azure Application Gateway ]
                                      │
                                      ▼
                        [ Laravel 12 API Cluster ]
                                      │
                ┌─────────────────────┼─────────────────────┐
                ▼                     ▼                     ▼
          [ MySQL 8 DB ]       [ Redis Cache ]     [ Azure Blob Storage ]
```

- **Backend**: Laravel 12 (PHP 8.4) API First REST architecture.
- **Database**: MySQL 8 with read-replicas for analytics queries.
- **Caching & Queues**: Redis for session storage, query caching, and async job queues.
- **Client Web Frontends**: Custom responsive SSR/SPA frontends per domain.
- **Mobile Client**: Single codebase Flutter app supporting iOS, Android, and Web.
- **Security Protocols**: Cloudflare DDoS mitigation, SSL/TLS 1.3, OWASP compliance, and AES-256 data encryption at rest.

---

## 8. Scalability & Global Expansion Roadmap

The system is architected to onboard new regional operating branches with zero backend refactoring:
- 🇸🇦 Saudi Arabia (Riyadh / Jeddah)
- 🇶🇦 Qatar (Doha)
- 🇴🇲 Oman (Muscat)
- 🇨🇦 Canada (Toronto / Vancouver)
- 🇦🇺 Australia (Sydney / Melbourne)

Adding a new country requires solely:
1. Country registry entry (Currency, Timezone, Languages).
2. Regional domain mapping.
3. Country-specific payroll formula configuration.
4. Localized SEO and content catalog upload.
