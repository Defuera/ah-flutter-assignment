import 'dart:convert';

import 'package:ah/common/model/data/error.dart';
import 'package:ah/common/model/data/models.dart';
import 'package:ah/common/model/network/api_responses.dart';
import 'package:ah/common/model/network/http_client.dart';
import 'package:ah/common/model/network/utils.dart';
import 'package:either_option/either_option.dart';

abstract class CollectionRemoteDataSource {
  Future<Either<RemoteError, List<ArtObject>>> getCollection(int page);

  Future<Either<RemoteError, ArtObjectDetailed>> getArtObject(String artObjectId);
}

class RijksDataApi extends CollectionRemoteDataSource {
  RijksDataApi(this.client);

  final HttpClient client;

  final _collectionEndpoint = '/collection';
  final _artObjectEndpoint = '/collection/[object-number]';
  final _perPage = 10;

  @override
  Future<Either<RemoteError, List<ArtObject>>> getCollection(int page) async {
    final jsonString = client.getJson('$_collectionEndpoint?ps=$_perPage&p=$page');
    return executeSafely<Map<String, dynamic>, List<ArtObject>>(
      jsonString,
      (json) => CollectionResponse.fromJson(json).artObjects,
    );
  }

  @override
  Future<Either<RemoteError, ArtObjectDetailed>> getArtObject(String artObjectId) async =>
      executeSafely<Map<String, dynamic>, ArtObjectDetailed>(
        client.getJson(_artObjectEndpoint.replaceAll('[object-number]', artObjectId)),
        (json) => ArtObjectResponse.fromJson(json).artObject,
      );
}

class MockApi extends CollectionRemoteDataSource {
  @override
  Future<Either<RemoteError, List<ArtObject>>> getCollection(int page) async {
    throw Exception('Not implemented');
  }

  @override
  Future<Either<RemoteError, ArtObjectDetailed>> getArtObject(String artObjectId) async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    return Right(ArtObjectResponse.fromJson(json.decode(_mockJson) as Map<String, dynamic>).artObject);
  }
}

const _mockJson = '''{
  "elapsedMilliseconds": 219,
  "artObject": {
    "links": {
      "search": "http://www.rijksmuseum.nl/api/nl/collection"
    },
    "id": "nl-SK-C-5",
    "priref": "5216",
    "objectNumber": "SK-C-5",
    "language": "nl",
    "title": "De Nachtwacht",
    "copyrightHolder": null,
    "webImage": {
      "guid": "aa08df9c-0af9-4195-b31b-f578fbe0a4c9",
      "offsetPercentageX": 50,
      "offsetPercentageY": 100,
      "width": 2500,
      "height": 2034,
      "url": "https://lh3.googleusercontent.com/J-mxAE7CPu-DXIOx4QKBtb0GC4ud37da1QK7CzbTIDswmvZHXhLm4Tv2-1H3iBXJWAW_bHm7dMl3j5wv_XiWAg55VOM=s0"
    },
    "colors": [
      {
        "percentage": 81,
        "hex": "#261808"
      }
    ],
    "colorsWithNormalization": [
      {
        "originalHex": "#261808",
        "normalizedHex": "#000000"
      }
    ],
    "normalizedColors": [
      {
        "percentage": 81,
        "hex": "#000000"
      }
    ],
    "normalized32Colors": [
      {
        "percentage": 81,
        "hex": "#000000"
      }
    ],
    "titles": [
      "Officieren en andere schutters van wijk II in Amsterdam, onder leiding van kapitein Frans Banninck Cocq en luitenant Willem van Ruytenburch, bekend als ‘De Nachtwacht’",
      "Het korporaalschap van kapitein Frans Banninck Cocq en luitenant Willem van Ruytenburch, bekend als de 'Nachtwacht'"
    ],
    "description": "Officieren en andere schutters van wijk II in Amsterdam onder leiding van kapitein Frans Banninck Cocq en luitenant Willem van Ruytenburch, sinds het einde van de 18de eeuw bekend als ‘De Nachtwacht’. Schutters van de Kloveniersdoelen uit een poort naar buiten tredend. Op een schild aangebracht naast de poort staan de namen van de afgebeelde personen: Frans Banning Cocq, heer van purmerlant en Ilpendam, Capiteijn Willem van Ruijtenburch van Vlaerdingen, heer van Vlaerdingen, Lu[ij]tenant, Jan Visscher Cornelisen Vaendrich, Rombout Kemp Sergeant, Reijnier Engelen Sergeant, Barent Harmansen, Jan Adriaensen Keyser, Elbert Willemsen, Jan Clasen Leydeckers, Jan Ockersen, Jan Pietersen bronchorst, Harman Iacobsen wormskerck, Jacob Dircksen de Roy, Jan vander heede, Walich Schellingwou, Jan brugman, Claes van Cruysbergen, Paulus Schoonhoven. De schutters zijn gewapend met onder anderen pieken, musketten en hellebaarden. Rechts de tamboer met een grote trommel. Tussen de soldaten links staat een meisje met een dode kip om haar middel, rechts een blaffende hond. Linksboven de vaandrig met de uitgestoken vaandel.",
    "labelText": null,
    "objectTypes": [
      "schilderij"
    ],
    "objectCollection": [
      "schilderijen"
    ],
    "makers": [],
    "principalMakers": [
      {
        "name": "Rembrandt van Rijn",
        "unFixedName": "Rijn, Rembrandt van",
        "placeOfBirth": "Leiden",
        "dateOfBirth": "1606-07-15",
        "dateOfBirthPrecision": null,
        "dateOfDeath": "1669-10-08",
        "dateOfDeathPrecision": null,
        "placeOfDeath": "Amsterdam",
        "occupation": [
          "prentmaker",
          "tekenaar",
          "schilder"
        ],
        "roles": [
          "schilder"
        ],
        "nationality": "Noord-Nederlands",
        "biography": null,
        "productionPlaces": [
          "Amsterdam"
        ],
        "qualification": null
      }
    ],
    "plaqueDescriptionDutch": "Rembrandts beroemdste en grootste doek werd gemaakt voor de Kloveniersdoelen. Dit was een van de verenigingsgebouwen van de Amsterdamse schutterij, de burgerwacht van de stad. Rembrandt was de eerste die op een groepsportret de figuren in actie weergaf. De kapitein, in het zwart, geeft zijn luitenant opdracht dat de compagnie moet gaan marcheren. De schutters stellen zich op. Met behulp van licht vestigde Rembrandt de aandacht op belangrijke details, zoals het handgebaar van de kapitein en het kleine meisje op de achtergrond. Zij is de mascotte van de schutters.",
    "plaqueDescriptionEnglish": "Rembrandt’s largest, most famous canvas was made for the Arquebusiers guild hall. This was one of several halls of Amsterdam’s civic guard, the city’s militia and police. Rembrandt was the first to paint figures in a group portrait actually doing something. The captain, dressed in black, is telling his lieutenant to start the company marching. The guardsmen are getting into formation. Rembrandt used the light to focus on particular details, like the captain’s gesturing hand and the young girl in the foreground. She was the company mascot.",
    "principalMaker": "Rembrandt van Rijn",
    "artistRole": null,
    "associations": [],
    "acquisition": {
      "method": "bruikleen",
      "date": "1808-01-01T00:00:00",
      "creditLine": "Bruikleen van de gemeente Amsterdam"
    },
    "exhibitions": [],
    "materials": [
      "doek",
      "olieverf"
    ],
    "techniques": [],
    "productionPlaces": [
      "Amsterdam"
    ],
    "dating": {
      "presentingDate": "1642",
      "sortingDate": 1642,
      "period": 17,
      "yearEarly": 1642,
      "yearLate": 1642
    },
    "classification": {
      "iconClassIdentifier": [
        "45(+26)"
      ]
    },
    "hasImage": true,
    "historicalPersons": [
      "Banninck Cocq, Frans"
    ],
    "inscriptions": [],
    "documentation": [
      "The Rembrandt Database,  Object information, Rembrandt,  Civic guardsmen of Amsterdam under command of Banninck Cocq,  dated 1642, Rijksmuseum, Amsterdam, inv. no. SK-C-5, http://www.rembrandtdatabase.org/Rembrandt/painting/3063/civic-guardsmen-of-amsterdam-under-command-of-banninck-cocq, accessed 2016 February 01"
    ],
    "catRefRPK": [],
    "principalOrFirstMaker": "Rembrandt van Rijn",
    "dimensions": [
      {
        "unit": "cm",
        "type": "hoogte",
        "part": null,
        "value": "379,5"
      }
    ],
    "physicalProperties": [],
    "physicalMedium": "olieverf op doek",
    "longTitle": "De Nachtwacht, Rembrandt van Rijn, 1642",
    "subTitle": "h 379,5cm × b 453,5cm × g 337kg",
    "scLabelLine": "Rembrandt van Rijn (1606–1669), olieverf op doek, 1642",
    "label": {
      "title": "De Nachtwacht",
      "makerLine": "Rembrandt van Rijn (1606–1669), olieverf op doek, 1642",
      "description": "Rembrandts beroemdste en grootste schilderij werd gemaakt voor de Kloveniersdoelen. Dit was een van de drie hoofdkwartieren van de Amsterdamse schutterij, de burgerwacht van de stad. Rembrandt was de eerste die op een schuttersstuk alle figuren in actie weergaf. De kapitein, in het zwart, geeft zijn luitenant opdracht dat de compagnie moet gaan marcheren. De schutters stellen zich op. Met behulp van licht vestigde Rembrandt de aandacht op belangrijke details, zoals het handgebaar van de kapitein en het kleine meisje op de voorgrond. Zij is de mascotte van de schutters. De naam Nachtwacht is pas veel later ontstaan, toen men dacht dat het om een nachtelijk tafereel ging.",
      "notes": "Multimediatour, 500. Tekst aangeleverd door Jonathan Bikker.",
      "date": "2019-07-05"
    },
    "showImage": true,
    "location": "HG-2.31"
  }
}''';
