import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeApi extends StatefulWidget {
  @override
  _HomeApiState createState() => _HomeApiState();
}

class _HomeApiState extends State<HomeApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("JSON placeholder"),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (ctx) => new MyApp()));
            },
          )
        ],
      ),
    );
  }
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget createRegionsListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return values.isNotEmpty
            ? Column(
                children: <Widget>[
                  ListTile(
                    title: Text(values[index].region),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                ],
              )
            : CircularProgressIndicator();
      },
    );
  }

  Widget createCountriesListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return ListView.builder(
      itemCount: values == null ? 0 : values.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCountry = values[index].code;
            });
            print(values[index].code);
            print(selectedCountry);
          },
          child: Column(
            children: <Widget>[
              new ListTile(
                title: Text(values[index].name),
                selected: values[index].code == selectedCountry,
              ),
              Divider(
                height: 2.0,
              ),
            ],
          ),
        );
      },
    );
  }

  final String API_KEY = "03f6c3123ea549f334f2f67c61980983";

  Future<List<Country>> getCountries() async {
    final response = await http
        .get('http://battuta.medunes.net/api/country/all/?key=$API_KEY');

    if (response.statusCode == 200) {
      var parsedCountryList = json.decode(response.body);
      List<Country> countries = List<Country>();
      parsedCountryList.forEach((country) {
        countries.add(Country.fromJSON(country));
      });
      return countries;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load ');
    }
  }

  Future<List<Region>> getRegions(String sl) async {
    final response = await http
        .get('http://battuta.medunes.net/api/region/$sl/all/?key=$API_KEY');

    if (response.statusCode == 200) {
      var parsedCountryList = json.decode(response.body);
      List<Region> regions = List<Region>();
      parsedCountryList.forEach((region) {
        regions.add(Region.fromJSON(region));
      });
      return regions;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load ');
    }
  }

  String selectedCountry = "AF";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(children: [
        Expanded(
          child: FutureBuilder(
              future: getCountries(),
              initialData: [],
              builder: (context, snapshot) {
                return createCountriesListView(context, snapshot);
              }),
        ),
        Expanded(
          child: FutureBuilder(
              future: getRegions(selectedCountry),
              initialData: [],
              builder: (context, snapshot) {
                return createRegionsListView(context, snapshot);
              }),
        ),
      ]),
    );
  }
}

class Country {
  String name;
  String code;

  Country({this.name, this.code});

  factory Country.fromJSON(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
    );
  }
}

class Region {
  String country;
  String region;

  Region({this.country, this.region});

  factory Region.fromJSON(Map<String, dynamic> json) {
    return Region(
      region: json["region"],
      country: json["country"],
    );
  }
}