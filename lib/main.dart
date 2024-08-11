import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp.router(
    theme: ThemeData(
      // Define the default brightness and colors.
      // brightness: Brightness.dark,
      primaryColor: Colors.blue,
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        // ···
        brightness: Brightness.dark,
      ),

      // Define the default font family.
      fontFamily: 'Raleway',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.oswald(
          fontSize: 30,
          fontStyle: FontStyle.italic,
        ),
        bodyMedium: GoogleFonts.merriweather(),
        displaySmall: GoogleFonts.pacifico(),
      ),
    ),
    routerConfig: routes,
  ));
}
