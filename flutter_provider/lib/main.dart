import 'package:flutter/material.dart';
import 'package:flutter_provider/flavor.dart';
import 'package:flutter_provider/my_app.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      Provider<Flavor>.value(
        value: Flavor.dev,
        child: MyApp(),
      ),
    );
