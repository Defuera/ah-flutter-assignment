class Property {
  // "AantalBadkamers": 1,
  final int? totalBedrooms;

  // "AantalKamers": 5,
  final int? totalRooms;

  // "Adres": "Cuijlenburg 52",
  final String? address;

  // "Postcode" -> "5831TM"
  final String? postcode;

  // "Plaats" -> "Boxmeer"
  final String? place;

  // "Bouwjaar": "2016",
  final String? constructionYear;

  // "Id": 6140616,
  final int? id;

  // HoofdFoto
  final String? mainPhotoUrl;

  // "VolledigeOmschrijving": "Ben je op zoek naar een instapklare, sfeervolle woning met een moderne uitstraling vlakbij het centrum van Boxmeer? Dan moet je de Cuijlenburg 52 komen bekijken! Deze verassend ruime tussenwoning is in 2016 gebouwd en is volledig geïsoleerd. Er is een gezellige open keuken met luxe inbouwapparatuur en een tuingerichte woonkamer. De zonnige tuin biedt veel privacy en heeft een houten fietsenschuur en een achterom. Op de eerste verdieping zijn 3 ruime slaapkamers en een modern ingerichte badkamer. Er is een vaste trap naar de tweede verdieping met grote raampartijen en een dakraam, waardoor je hier eenvoudig een extra slaapkamer kunt realiseren en er toch nog veel bergruimte beschikbaar blijft. Nieuwsgierig geworden? Maak dan snel een afspraak voor een bezichtiging van deze prachtige woning.\n\nBijzonderheden:\n-\tJonge woning uit 2016, instapklaar en in moderne lichte kleuren afgewerkt\n-\tVolledig geïsoleerd \n-\tEenvoudig vierde ruime slaapkamer te realiseren op de tweede verdieping\n-\tRustig gelegen nabij uitvalswegen en het gezellige centrum van Boxmeer\n-\tAltijd parkeerplaats beschikbaar voor de deur\n-\tDe slaapkamers aan de achterzijde van de woning hebben rolluiken\n-\tDe gehele woning is voorzien van een laminaatvloer (woonkamer nog geen 6 maanden oud)\n\nIndeling:\nBegane grond: hal, meterkast, toilet met fonteintje, open keuken met inbouwapparatuur zoals vaatwasser, koelkast, vriezer, combimagnetron, inductiekookplaat en afzuigkap. Woonkamer met provisiekast, uitzicht en toegang tot de tuin. \n\nVerdieping: overloop, 3 slaapkamers, moderne badkamer met inloopdouche, toilet en wastafelmeubel. \n\nZolder: vaste trap naar hoge open zolder met aansluitingen voor de wasmachine, CV-installatie en ventilatiesysteem.  Hier kun je eenvoudig een vierde ruime slaapkamer met dakraam realiseren. \n\nKenmerken:\nType woning: Tussenwoning met houten berging\nBouwjaar: 2016\nWoonoppervlakte: 140 m²\nExterne bergruimte: 6 m²\nInhoud woning: 535 m³\nPerceelgrootte: 136 m²\nAantal slaapkamers: 3 slaapkamers\nVerwarming en warm water: CV-installatie Intergas 2016, Duco ventilatiesysteem 2016\nElectra: Uitgebreide meterkast met ruim voldoende groepen en  aardlekschakelaars \nIsolatie: Geheel geïsoleerd\nEnergielabel: A\nGlasvezel aanwezig: ja",
  final String? completeDescription;

  // "KoopPrijs": 325000,
  final int? price;

  // WoonOppervlakte
  final int? livingArea;

  // PerceelOppervlakte
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

// "WGS84_X": 5.94154644,
// "WGS84_Y": 51.6535759,

}
