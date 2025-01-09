import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchDataDep() async {
  Map<String, dynamic> result = {};
  try {
    final response = await http.get(Uri.parse('https://data.opendatasoft.com/api/explore/v2.1/catalog/datasets/contours-geographiques-tres-simplifies-des-departements-2019@public/records?select=geo_point_2d%2C%20nom_dep%2C%20insee_dep&order_by=nom_dep&limit=100'));

    if (response.statusCode == 200) {
      // Les données ont été récupérées avec succès

      Map<String, dynamic> donnees = jsonDecode(response.body);
      result = donnees;

    } else {
      throw Exception('Échec du chargement des données');
    }
  } catch (e) {
    print('Erreur: $e');
  }
  return result ;
}

