import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/screen/home/homeScreen.dart';
import 'package:fkbn_flutter/screen/login/loginScreen.dart';
import 'package:fkbn_flutter/screen/onBoarding/onBoardingScreen.dart';
import 'package:fkbn_flutter/screen/splashScreen.dart';
import 'package:fkbn_flutter/screen/user_profile/changePasswordScreen.dart';
import 'package:fkbn_flutter/screen/user_profile/userProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final HttpLink link = HttpLink("http://localhost:4001/");
    // final HttpLink httpLink =
    //     HttpLink("http://10.0.2.2:4001/.", defaultHeaders: {
    //   "content-type": "application/json",
    // });

    // final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    //     GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore())));

    return GraphQLProvider(
      client: MultiQuery().client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fansapp',
        home: SplashScreen(),
      ),
    );
  }
}
