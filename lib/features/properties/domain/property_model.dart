import 'package:equatable/equatable.dart';

class Property extends Equatable {
  final String id;
  final String title;
  final String price;
  final String location;
  final String countryCode; // AE, BD, UK, US
  final int bedrooms;
  final int bathrooms;
  final double areaSqft;
  final String imageUrl;
  final List<String> galleryUrls;
  final String description;
  final String tag; // For Sale, For Rent
  final bool isSaved;
  final String propertyType; // Apartment, Villa, Penthouse, House
  final double matchScore; // e.g. 96.5% for lead matching
  final String agentName;
  final String agentPhone;
  final String agentImage;
  final String agencyName;

  const Property({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    this.countryCode = 'AE',
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqft,
    required this.imageUrl,
    required this.galleryUrls,
    required this.description,
    this.tag = 'For Sale',
    this.isSaved = false,
    this.propertyType = 'Apartment',
    this.matchScore = 95.0,
    this.agentName = 'Sarah Jenkins',
    this.agentPhone = '+971 4 398 2100',
    this.agentImage = 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
    this.agencyName = 'Nova Global Development',
  });

  Property copyWith({
    bool? isSaved,
    String? countryCode,
  }) {
    return Property(
      id: id,
      title: title,
      price: price,
      location: location,
      countryCode: countryCode ?? this.countryCode,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      areaSqft: areaSqft,
      imageUrl: imageUrl,
      galleryUrls: galleryUrls,
      description: description,
      tag: tag,
      isSaved: isSaved ?? this.isSaved,
      propertyType: propertyType,
      matchScore: matchScore,
      agentName: agentName,
      agentPhone: agentPhone,
      agentImage: agentImage,
      agencyName: agencyName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        location,
        countryCode,
        bedrooms,
        bathrooms,
        areaSqft,
        imageUrl,
        galleryUrls,
        description,
        tag,
        isSaved,
        propertyType,
        matchScore,
        agentName,
        agentPhone,
        agentImage,
        agencyName,
      ];

  static List<Property> get sampleProperties => const [
        // UAE Properties (AE)
        Property(
          id: 'prop-1',
          title: 'The Skyview Penthouse & Residence',
          price: 'AED 9,250,000',
          location: 'Dubai Marina Waterfront, UAE',
          countryCode: 'AE',
          bedrooms: 4,
          bathrooms: 4,
          areaSqft: 4850,
          tag: 'For Sale',
          propertyType: 'Penthouse',
          imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Luxurious double-height skyline penthouse featuring 360-degree panoramic Arabian Gulf and Marina views, private infinity plunge pool, automated smart glass, and Italian marble accents.',
          isSaved: true,
          matchScore: 98.4,
          agentName: 'Tariq Al Mansoori',
          agentPhone: '+971 4 398 2100',
          agencyName: 'Nova UAE Development',
        ),
        Property(
          id: 'prop-2',
          title: 'Downtown Burj Crown Luxury Suite',
          price: 'AED 3,450,000',
          location: 'Downtown Boulevard, Dubai, UAE',
          countryCode: 'AE',
          bedrooms: 2,
          bathrooms: 3,
          areaSqft: 2200,
          tag: 'For Sale',
          propertyType: 'Apartment',
          imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Contemporary architectural masterpiece facing the iconic Burj Khalifa, featuring private concierge services, floor-to-ceiling acoustic glass, and premium Miele kitchen suite.',
          isSaved: false,
          matchScore: 92.1,
          agentName: 'Tariq Al Mansoori',
          agentPhone: '+971 4 398 2100',
          agencyName: 'Nova UAE Development',
        ),

        // Bangladesh Properties (BD)
        Property(
          id: 'prop-3',
          title: 'The Gulshan Signature Lakeside Villa',
          price: 'BDT 18,50,00,000',
          location: 'Road 79, Gulshan-2, Dhaka, Bangladesh',
          countryCode: 'BD',
          bedrooms: 5,
          bathrooms: 6,
          areaSqft: 6500,
          tag: 'For Sale',
          propertyType: 'Villa',
          imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Prestige lakeside residence in prime diplomatic zone. Private elevator, rooftop infinity terrace, VRF multi-zone cooling, standby dual generator, and advanced biometric perimeter security.',
          isSaved: true,
          matchScore: 96.2,
          agentName: 'Mohammad Saiful Islam',
          agentPhone: '+880 1711 900222',
          agencyName: 'Nova Bangladesh Ltd',
        ),
        Property(
          id: 'prop-4',
          title: 'Banani Diplomatic Enclave Suites',
          price: 'BDT 3,20,000 / mo',
          location: 'Block F, Banani, Dhaka, Bangladesh',
          countryCode: 'BD',
          bedrooms: 3,
          bathrooms: 4,
          areaSqft: 3200,
          tag: 'For Rent',
          propertyType: 'Apartment',
          imageUrl: 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Boutique single-unit-per-floor condominium with smart home automation, dedicated maid quarters, double parking slots, and rooftop gym.',
          isSaved: false,
          matchScore: 91.5,
          agentName: 'Mohammad Saiful Islam',
          agentPhone: '+880 1711 900222',
          agencyName: 'Nova Bangladesh Ltd',
        ),

        // UK Properties (UK)
        Property(
          id: 'prop-5',
          title: 'Mayfair Royal Crescent Mews',
          price: '£3,850,000',
          location: 'South Audley Street, Mayfair, London, UK',
          countryCode: 'UK',
          bedrooms: 3,
          bathrooms: 3,
          areaSqft: 2850,
          tag: 'For Sale',
          propertyType: 'House',
          imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Elegantly restored Georgian mews freehold house moments from Hyde Park. Features bespoke handcrafted oak joinery, temperature-controlled wine cellar, and private garage.',
          isSaved: true,
          matchScore: 94.8,
          agentName: 'Arthur Kensington',
          agentPhone: '+44 20 7946 0912',
          agencyName: 'Nova UK Prime Properties',
        ),

        // USA Properties (US)
        Property(
          id: 'prop-6',
          title: 'Hudson Yards Sky Villa',
          price: '\$4,250,000',
          location: '10th Avenue, Manhattan, New York, USA',
          countryCode: 'US',
          bedrooms: 4,
          bathrooms: 4,
          areaSqft: 3400,
          tag: 'For Sale',
          propertyType: 'Penthouse',
          imageUrl: 'https://images.unsplash.com/photo-1567496898669-ee935f5f647a?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1567496898669-ee935f5f647a?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Corner aerie suspended high above the Hudson River with floor-to-ceiling curtain walls, custom Molteni kitchen, private elevator vestibule, and Equinox club privileges.',
          isSaved: false,
          matchScore: 97.1,
          agentName: 'Jessica Vance',
          agentPhone: '+1 (212) 555-0199',
          agencyName: 'Nova USA Development',
        ),
      ];
}
