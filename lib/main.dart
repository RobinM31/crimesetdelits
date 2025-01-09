import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graphic/graphic.dart';
import 'API_latLong_reg.dart';
import 'API_latLong_dep.dart';
import 'api_crimes_par_region.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Crimes et Délits'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  List<LatLng> listechefLieu = [];
  List<LatLng> listePref = [];
  int index = 0;

  @override
  void initState() {
    listeDeMarkerDep();
    listeDeMarkerReg();
    liste5DepSur();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: <Widget>[
        Container(
          child: Column(
            children: [
              ElevatedButton(onPressed: liste5DepSur , child: Text("departement et faits"))

            ],
          )
        ),
        Container(
          child: FlutterMap(
            options: MapOptions(
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              initialCenter: LatLng(47.466671, -0.55), // Center the map over London
              initialZoom: 5.0,
            ),
            children: [
              TileLayer( // Display map tiles from any source
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                userAgentPackageName: 'com.example.app',
                // And many more recommended properties!
              ),

              index < 1 ? CircleLayer(
                circles: listechefLieu.map((l) => CircleMarker(
                  point: l,
                  radius: 10000,
                  useRadiusInMeter: true,
                  color: Colors.red.withOpacity(0.7),
                )).toList(),
              ):
              CircleLayer(
                circles: listePref.map((l) => CircleMarker(
                  point: l,
                  radius: 10000,
                  useRadiusInMeter: true,
                  color: Colors.red.withOpacity(0.7),
                )).toList(),
              ),
              RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
                  ),
                  // Also add images...
                  //afficher la list de marker

                ],
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: listeDeMarkerReg,
                      child:Text('Région') ),
                  ElevatedButton(onPressed: listeDeMarkerDep,
                      child:Text('Département') ),
                ],
              )
            ],
          ),
        ),
      ][currentPageIndex],

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'Carte',
          ),
        ],
      ),
    );
  }
  Future listeDeMarkerReg () async {
    List<LatLng> listefinale = [];
    final reg  =  await fetchData();
    if(reg != null){
    for(Map<String, dynamic> elt in reg["results"]){
      listefinale.add(LatLng(elt["geo_point_2d"]["lat"],elt["geo_point_2d"]["lon"]));
    }
    setState(() {

      listechefLieu = listefinale;
      index = 0;
    });
    }
  }

  Future listeDeMarkerDep () async {
    List<LatLng> listefinale = [];
    final dep  =  await fetchDataDep();
    if(dep != null){
      for(Map<String, dynamic> elt in dep["results"]){
        listefinale.add(LatLng(elt["geo_point_2d"]["lat"],elt["geo_point_2d"]["lon"]));
      }
      setState(() {

        listePref = listefinale;
        index = 1;
      });
    }
  }
  Future liste5DepSur() async {
    Map<int, int> listefinale = {};
    final stat  =  await fetchDataAll();
    for(Map<String, dynamic> elt in stat["data"]){

      listefinale.addAll({elt["Code.région"] : elt["faits"]});
      print(listefinale);

    }
  }

}
