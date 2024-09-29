import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youapp_technical_test/core/router/app_router.dart';
import 'package:youapp_technical_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:youapp_technical_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:youapp_technical_test/data/repositories/auth_repository.dart';
import 'package:youapp_technical_test/data/repositories/profile_repository.dart';
import 'package:youapp_technical_test/presentation/pages/login_page.dart';
import 'package:youapp_technical_test/presentation/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository())
            ..add(CheckAuthStatusEvent()),
        ),
        BlocProvider(
          create: (context) =>
              ProfileBloc(profileRepository: ProfileRepository())
                ..add(GetProfileEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: 'YouApp Technical Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
