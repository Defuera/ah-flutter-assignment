class Property {
  final int? totalBedrooms;
  final int? totalRooms;
  final String? address;
  final String? postcode;
  final String? place;
  final String? constructionYear;
  final int? id;
  final String? mainPhotoUrl;
  final String? completeDescription;
  final int? price;
  final int? livingArea;
  final int? groundArea;

  Property({
    required this.totalBedrooms,
    required this.totalRooms,
    required this.address,
    required this.postcode,
    required this.place,
    required this.constructionYear,
    required this.id,
    required this.mainPhotoUrl,
    required this.completeDescription,
    required this.price,
    required this.livingArea,
    required this.groundArea,
  });

  static Property fromJson(Map<String, dynamic> json) => Property(
        totalBedrooms: json['AantalBadkamers'] as int?,
        totalRooms: json['AantalKamers'] as int?,
        address: json['Adres'] as String?,
        postcode: json['Postcode'] as String?,
        place: json['Plaats'] as String?,
        constructionYear: json['Bouwjaar'] as String?,
        id: json['id'] as int?,
        mainPhotoUrl: json['HoofdFoto'] as String?,
        completeDescription: json['VolledigeOmschrijving'] as String?,
        price: json['KoopPrijs'] as int?,
        livingArea: json['WoonOppervlakte'] as int?,
        groundArea: json['PerceelOppervlakte'] as int?,
      );
}
