import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/bloc/page_bloc.dart';
import 'package:bwa_flutix/bloc/user_bloc.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/view/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/theme_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(create: (_) => MovieBloc()..add(FetchMovie())),
          BlocProvider(create: (_) => TicketBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              home: Wrapper(),
            );
          },
        ),
      ),
    );
  }
}
