import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchDataAll() async {
  Map<String, dynamic> result = {};
  try {
    final response = await http.get(Uri.parse('https://tabular-api.data.gouv.fr/api/resources/acc332f6-92be-42af-9721-f3609bea8cfc/data/'));

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

