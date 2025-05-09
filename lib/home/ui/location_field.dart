import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../cubit/weather_cubit.dart';

class LocationAutoComplete extends StatefulWidget {
  const LocationAutoComplete({super.key});

  @override
  State<LocationAutoComplete> createState() => _LocationAutoCompleteState();
}

class _LocationAutoCompleteState extends State<LocationAutoComplete> {
  final TextEditingController _cityController = TextEditingController();
  final String token = '123467890';

  var uuid = const Uuid();

  List<dynamic> listOfLocation = [];

  @override
  void initState() {
    _cityController.addListener(() {
      _onChange();
    });
    super.initState();
  }

  _onChange() {
    placeSuggestion(_cityController.text);
  }

  void placeSuggestion(String input) async {
    String mapsApiKey = dotenv.env["GOOGLE_MAPS_API_KEY"]!;

    try {
      String baseUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";

      String request =
          '$baseUrl?input=$input&key=$mapsApiKey&sessiontoken=$token';

      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          listOfLocation = json.decode(response.body)['predictions'];
        });
      } else {}
      throw Exception('Fail to load');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _cityController,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Search city',
              hintStyle: GoogleFonts.montserrat(
                color: Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  final city = _cityController.text.trim();
                  if (city.isNotEmpty) {
                    context.read<WeatherCubit>().fetchWeather(city);
                  }
                },
              ),
            ),
            onSubmitted: (value) {
              final city = value.trim();
              if (city.isNotEmpty) {
                context.read<WeatherCubit>().fetchWeather(city);
              }
            },
          ),
        ),

        const SizedBox(height: 8),

        // Autocomplete Dropdown List
        if (listOfLocation.isNotEmpty)
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200, // Limit the height of the dropdown
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listOfLocation.length,
                itemBuilder: (context, index) {
                  final location = listOfLocation[index];
                  return ListTile(
                    title: Text(
                      location['description'],
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      // Update the text field and clear the list
                      setState(() {
                        _cityController.text = location['description'];
                        listOfLocation = [];
                      });
                      // Fetch weather for the selected location
                      context.read<WeatherCubit>().fetchWeather(
                        location['description'],
                      );
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
