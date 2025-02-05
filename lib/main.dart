import 'package:camera/camera.dart';
import 'package:cidadao/app/route_generate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MainApp());
}

Future<Position> determinePosition() async {
  bool serviceEnabled;

  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 100,
  );

  return await Geolocator.getCurrentPosition(
    locationSettings: locationSettings,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext   context) {
    FlutterNativeSplash.remove();

    return ScreenUtilInit(
      // iPhone 14/15 Pro Max size
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: "TiddyVille",
          // theme: ThemeData(
          //   useMaterial3: true,
          //   fontFamily: GoogleFonts.inter().fontFamily,
          //   colorScheme: ColorScheme(
          //     brightness: Brightness.light,
          //     primary: Color(0xFF3a6642), // Verde 1 (700) - Cor primária
          //     onPrimary: Color(
          //         0xFFf6f6f6), // Cinza (50) - Cor do texto sobre a cor primária
          //     secondary:
          //         Color(0xFF88bc64), // Verde Claro (400) - Cor secundária
          //     onSecondary: Color(
          //         0xFF2e4d34), // Verde 1 (800) - Cor do texto sobre a cor secundária
          //     error: Color(
          //         0xFFbc6262), // Cor de erro (não presente no esquema, variação de vermelho)
          //     onError:
          //         Colors.white, // Verde 1 (900) - Cor do texto sobre o fundo
          //     surface: Color(
          //         0xFFf6f6f6), // Cinza (50) - Cor de superfície (cards, etc.)
          //     onSurface: Color(
          //         0xFF37623A), // Verde 2 (700) - Cor do texto sobre a superfície
          //     outline: Color(0xFF3A6642), // Verde 1 (700) - Usado para bordas
          //   ),
          //   navigationBarTheme: const NavigationBarThemeData(
          //     backgroundColor: Color(0xFFf6f6f6), // Cinza (50)
          //     indicatorColor: Color(0xFFcee4d2), // Verde 1 (200)
          //     iconTheme: WidgetStatePropertyAll(
          //       IconThemeData(
          //         color: Color(
          //             0xFF8b8a84), // Cinza (500) - Cor dos ícones não selecionados
          //       ),
          //     ),
          //     labelTextStyle: WidgetStatePropertyAll(
          //       TextStyle(
          //         color: Color(
          //             0xFF8b8a84), // Cinza (500) - Cor dos labels não selecionados
          //       ),
          //     ),
          //   ),
          //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
          //     backgroundColor: Color(0xFFcee4d2), // Verde 1 (200)
          //     foregroundColor: Color(0xFF2e4d34), // Verde 1 (800)
          //   ),
          //   elevatedButtonTheme: ElevatedButtonThemeData(
          //     style: ButtonStyle(
          //       backgroundColor: WidgetStatePropertyAll(
          //         Color(0xFF3a6642), // Verde 1 (700)
          //       ),
          //       foregroundColor: const WidgetStatePropertyAll(
          //         Color(0xFFf6f6f6), // Cinza (50)
          //       ),
          //       overlayColor: WidgetStatePropertyAll(
          //         Color(0xFFa6cfad), // Verde 1 (300)
          //       ),
          //     ),
          //   ),
          //   outlinedButtonTheme: OutlinedButtonThemeData(
          //     style: ButtonStyle(
          //       foregroundColor: const WidgetStatePropertyAll(
          //         Color(0xFF3a6642), // Verde 1 (700)
          //       ),
          //       overlayColor: WidgetStatePropertyAll(
          //         Color(0xFFa6cfad).withValues(
          //             alpha: 0.2), // Verde 1 (300) com 20% de opacidade
          //       ),
          //     ),
          //   ),
          //   inputDecorationTheme: InputDecorationTheme(
          //     labelStyle: GoogleFonts.inter(
          //       fontSize: 12.sp,
          //       color: const Color(0xFF8b8a84),
          //     ),
          //     disabledBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(
          //         color: Color(0xFF8b8a84),
          //       ),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(16.r),
          //       ),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(
          //         color: Color(0xFF3A6642),
          //       ),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(16.r),
          //       ),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(
          //         color: Color(0xFF3A6642),
          //       ),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(16.r),
          //       ),
          //     ),
          //     errorBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(
          //         color: Color(0xFFbc6262),
          //       ),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(16.r),
          //       ),
          //     ),
          //     focusedErrorBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(
          //         color: Color(0xFFbc6262),
          //       ),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(16.r),
          //       ),
          //     ),
          //   ),

          //   // colorScheme: ColorScheme.fromSeed(
          //   //   seedColor: const Color(0xff82bd69),
          //   //   primary: const Color(0xff82bd69),
          //   //   secondary: const Color(0xff4c8435),
          //   //   surface: Colors.white,
          //   // ),
          // ),
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Color(
                  0xFF3a6642), // Verde 1 (700) - Cor primária (usada em elevatedButton)
              onPrimary: Color(
                  0xFFf6f6f6), // Cinza (50) - Cor do texto sobre a cor primária (usada em elevatedButton)
              secondary:
                  Color(0xFF88bc64), // Verde Claro (400) - Cor secundária
              onSecondary: Color(
                  0xFF2e4d34), // Verde 1 (800) - Cor do texto sobre a cor secundária
              error: Color(
                  0xFFbc6262), // Cor de erro (usada em PasswordValidator e TextFormField)
              onError:
                  Colors.white, // Verde 2 (700) - Cor do texto sobre o fundo
              surface: Color(
                  0xFFf6f6f6), // Cinza (50) - Cor de superfície (cards, etc.)
              onSurface: Color(
                  0xFF37623A), // Verde 2 (700) - Cor do texto sobre a superfície (usada em TextFormField)
              outline: Color(
                  0xFF3A6642), // Verde 1 (700) - Usado para bordas (usada em TextFormField)
            ),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Color(0xFFf6f6f6), // Cinza (50)
              indicatorColor: Color(0xFFcee4d2), // Verde 1 (200)
              iconTheme: WidgetStatePropertyAll(
                IconThemeData(
                  color: Color(
                      0xFF8b8a84), // Cinza (500) - Cor dos ícones não selecionados
                ),
              ),
              labelTextStyle: WidgetStatePropertyAll(
                TextStyle(
                  color: Color(
                      0xFF8b8a84), // Cinza (500) - Cor dos labels não selecionados
                ),
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFFcee4d2), // Verde 1 (200)
              foregroundColor: Color(0xFF2e4d34), // Verde 1 (800)
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color(0xFF3a6642), // Verde 1 (700)
                ),
                foregroundColor: const WidgetStatePropertyAll(
                  Color(0xFFf6f6f6), // Cinza (50)
                ),
                overlayColor: WidgetStatePropertyAll(
                  Color(0xFFa6cfad).withValues(
                      alpha: 0.2), // Verde 1 (300) com 20% de opacidade
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: const WidgetStatePropertyAll(
                  Color(0xFF3a6642), // Verde 1 (700)
                ),
                overlayColor: WidgetStatePropertyAll(
                  Color(0xFFa6cfad).withValues(
                      alpha: 0.2), // Verde 1 (300) com 20% de opacidade
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF8b8a84), // Cinza (500)
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF8b8a84), // Cinza (500)
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF3A6642), // Verde 1 (700)
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF3A6642), // Verde 1 (700)
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFbc6262), // Vermelho para erro
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFbc6262), // Vermelho para erro
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
              ),
            ),
          ),
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}

/*
  Verde 1(#3a6642):
  '50': '#f4f9f5',
  '100': '#e6f2e8',
  '200': '#cee4d2',
  '300': '#a6cfad',
  '400': '#78b081',
  '500': '#54935f',
  '600': '#42774b',
  '700': '#3a6642',
  '800': '#2e4d34',
  '900': '#27402c',
  '950': '#122115',
  
  Verde 2(#37623a):
    '50': '#f4f9f4',
    '100': '#e6f2e6',
    '200': '#cde5ce',
    '300': '#a6cfa9',
    '400': '#77b17a',
    '500': '#549358',
    '600': '#417844',
    '700': '#37623a',
    '800': '#2e4d31',
    '900': '#274029',
    '950': '#112213',
    
  Verde Claro(#88bc64):
    '50': '#f3f8ed',
    '100': '#e3f0d7',
    '200': '#c8e2b4',
    '300': '#a6cf87',
    '400': '#88bc64',
    '500': '#679f43',
    '600': '#4f7e32',
    '700': '#3d612a',
    '800': '#354e26',
    '900': '#2e4423',
    '950': '#16240f',
  
  Cinza(#dcdcda): 
    '50': '#f6f6f6',
    '100': '#ebebe9',
    '200': '#dcdcda',
    '300': '#babab7',
    '400': '#9e9d99',
    '500': '#8b8a84',
    '600': '#7e7d78',
    '700': '#6a6964',
    '800': '#585754',
    '900': '#494845',
    '950': '#262624',

  Azul Escuro 1(#192C36):
    '50': '#f1f8fa',
    '100': '#dceff1',
    '200': '#bcdee5',
    '300': '#8ec6d2',
    '400': '#59a5b7',
    '500': '#3d899d',
    '600': '#357085',
    '700': '#315c6d',
    '800': '#2f4e5b',
    '900': '#2b434e',
    '950': '#192c36',
  
  Azul Escuro 2(#001a2b):
    '50': '#eef9ff',
    '100': '#dcf3ff',
    '200': '#b2e9ff',
    '300': '#6ddaff',
    '400': '#20c7ff',
    '500': '#00b0ff',
    '600': '#008ddf',
    '700': '#0070b4',
    '800': '#005f95',
    '900': '#004e7a',
    '950': '#001a2b',
    
*/
