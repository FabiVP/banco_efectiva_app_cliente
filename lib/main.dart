import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/api/api_client.dart';
import 'core/theme/app_theme.dart';
import 'presentation/client_app/screens/login_screen.dart';
import 'presentation/client_app/screens/registro_screen.dart';
import 'presentation/client_app/screens/home_screen.dart';
import 'presentation/client_app/screens/transferencias_screen.dart';
import 'presentation/client_app/screens/tarjeta_screen.dart';
import 'presentation/client_app/screens/pagos_screen.dart';
import 'presentation/client_app/screens/limites_screen.dart';
import 'presentation/client_app/screens/perfil_screen.dart';
import 'presentation/client_app/screens/ahorros_screen.dart';
import 'presentation/client_app/screens/creditos_screen.dart';
import 'presentation/client_app/screens/solicitud_screen.dart';
import 'presentation/client_app/viewmodels/auth_viewmodel.dart';
import 'presentation/client_app/viewmodels/home_viewmodel.dart';
import 'presentation/client_app/viewmodels/creditos_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await ApiClient().init();
  runApp(const EfectivaApp());
}

class EfectivaApp extends StatelessWidget {
  const EfectivaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CreditosViewModel()),
      ],
      child: MaterialApp(
        title: 'Efectiva - Tu financiera',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/registro': (context) => const RegistroScreen(),
          '/home': (context) => const HomeScreen(),
          '/transferencias': (context) => const TransferenciasScreen(),
          '/tarjeta': (context) => const TarjetaScreen(),
          '/pagos': (context) => const PagosScreen(),
          '/limites': (context) => const LimitesScreen(),
          '/perfil': (context) => const PerfilScreen(),
          '/ahorros': (context) => const AhorrosScreen(),
          '/creditos': (context) => const CreditosScreen(),
          '/solicitar-credito': (context) => const SolicitudScreen(),
        },
      ),
    );
  }
}