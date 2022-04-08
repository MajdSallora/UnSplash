import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Backend/FeatchPictureBloc/Picture_Bloc.dart';
import 'Backend/FeatchPictureBloc/ApiRepository.dart';
import 'package:unsplash/Screens/Home_Screen.dart';
import 'Backend/search/SearchBloc.dart';
import 'Backend/search/SearchResp.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(Providing());
}

class Providing extends StatefulWidget {
  @override
  State<Providing> createState() => _ProvidingState();
}

class _ProvidingState extends State<Providing> {
  final ApiRepository repository = ApiRepository();

  final SearchBloc _newsBloc2 =
      SearchBloc(pictureRepository: SearchRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PictureBloc(repository)),
        BlocProvider(create: (context) => _newsBloc2),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    removeSplash();
  }

  void removeSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }
}
