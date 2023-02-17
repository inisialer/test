import 'package:alhikmah_app/bloc/master/bloc.dart';
import 'package:alhikmah_app/bloc/memberregistration/bloc.dart';
import 'package:alhikmah_app/bloc/payment/bloc.dart';
import 'package:alhikmah_app/bloc/ppob/bpjs/bloc.dart';
import 'package:alhikmah_app/bloc/ppob/pdam/bloc.dart';
import 'package:alhikmah_app/bloc/ppob/pln/bloc.dart';
import 'package:alhikmah_app/bloc/ppob/pulsa/bloc.dart';
import 'package:alhikmah_app/bloc/user/bloc.dart';
import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/bloc/zipay/bloc.dart';
import 'package:alhikmah_app/screen/start/splashbasmallah/splash_basmallah_screen.dart';
import 'package:alhikmah_app/util/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'app.dart';
import 'bloc/auth/bloc.dart';
import 'data/endpoint.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  App.configure(apiBaseURL: Endpoint.baseURLDev, appTitle: 'Al-Hikmah App');

  await App().init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc()),
        BlocProvider<UtilBloc>(create: (BuildContext context) => UtilBloc()),
        BlocProvider<MasterBloc>(
            create: (BuildContext context) => MasterBloc()),
        BlocProvider<PaymentBloc>(
            create: (BuildContext context) => PaymentBloc()),
        BlocProvider<PulsaBloc>(create: (BuildContext context) => PulsaBloc()),
        BlocProvider<PlnBloc>(create: (BuildContext context) => PlnBloc()),
        BlocProvider<BpjsBloc>(create: (BuildContext context) => BpjsBloc()),
        BlocProvider<PdamBloc>(create: (BuildContext context) => PdamBloc()),
        BlocProvider<MemberRegistrationBloc>(
            create: (BuildContext context) => MemberRegistrationBloc()),
        BlocProvider<ZipayBloc>(create: (BuildContext context)=> ZipayBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashBasmallahScreen(),
        routes: routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
