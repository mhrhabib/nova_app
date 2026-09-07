import 'package:equatable/equatable.dart';

class Property extends Equatable {
  final String id;
  final String title;
  final String price;
  final String location;
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
    this.agentPhone = '+1 (555) 234-5678',
    this.agentImage = 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
    this.agencyName = 'Apex Luxury Realty',
  });

  Property copyWith({
    bool? isSaved,
  }) {
    return Property(
      id: id,
      title: title,
      price: price,
      location: location,
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
        Property(
          id: 'prop-1',
          title: 'The Skyview Penthouse & Residence',
          price: '\$2,450,000',
          location: 'Downtown Waterfront, Metro City',
          bedrooms: 4,
          bathrooms: 4,
          areaSqft: 3850,
          tag: 'For Sale',
          propertyType: 'Penthouse',
          imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Luxurious double-height skyline penthouse featuring 360-degree panoramic ocean views, private infinity plunge pool, automated smart glass, and floor-to-ceiling Italian marble accents.',
          isSaved: true,
          matchScore: 98.4,
        ),
        Property(
          id: 'prop-2',
          title: 'Modern Minimalist Villa with Infinity Pool',
          price: '\$1,890,000',
          location: 'Beverly Hills Crest, Sunset Strip',
          bedrooms: 5,
          bathrooms: 6,
          areaSqft: 4500,
          tag: 'For Sale',
          propertyType: 'Villa',
          imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
            'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Contemporary architectural masterpiece with seamless indoor-outdoor living, teak decks, solar integration, and high-end Miele appliances.',
          isSaved: false,
          matchScore: 92.1,
        ),
        Property(
          id: 'prop-3',
          title: 'Elegance Garden Heights Residence',
          price: '\$6,500 / mo',
          location: 'Greenwich Avenue, Urban District',
          bedrooms: 3,
          bathrooms: 2,
          areaSqft: 2100,
          tag: 'For Rent',
          propertyType: 'Apartment',
          imageUrl: 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Light-filled residence situated directly beside lush private parks, offering 24/7 concierge, state-of-the-art gym, and reserved underground parking.',
          isSaved: true,
          matchScore: 89.0,
        ),
        Property(
          id: 'prop-4',
          title: 'Coastal Horizon Villa',
          price: '\$3,120,000',
          location: 'Malibu Bay Cove',
          bedrooms: 4,
          bathrooms: 5,
          areaSqft: 3900,
          tag: 'For Sale',
          propertyType: 'Villa',
          imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80',
          galleryUrls: [
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80',
          ],
          description: 'Private beachfront enclave with direct private boardwalk access, floor-to-ceiling glass walls, sunset terrace, and organic wood design.',
          isSaved: false,
          matchScore: 94.7,
        ),
      ];
}
