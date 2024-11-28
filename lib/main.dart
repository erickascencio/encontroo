import 'package:encontroo/screens/promoter/createEventScreen.dart';
import 'package:encontroo/screens/promoter/editEventScreen.dart';
import 'package:encontroo/screens/promoter/eventDetailScreen.dart';
import 'package:encontroo/screens/promoter/promEditProfileScreen.dart';
import 'package:encontroo/screens/promoter/promHomeScreen.dart';
import 'package:encontroo/screens/promoter/promLoginScreen.dart';
import 'package:encontroo/screens/promoter/promProfileScreen.dart';
import 'package:encontroo/screens/register.dart';
import 'package:encontroo/screens/tinder/chatScreen.dart';
import 'package:encontroo/screens/tinder/matchsSreen.dart';
import 'package:encontroo/screens/tinder/tinderFeedScreen.dart';
import 'package:encontroo/screens/user/userEditProfileScreen.dart';
import 'package:encontroo/screens/user/userEventDetailScreen.dart';
import 'package:encontroo/screens/user/userEventScreen.dart';
import 'package:encontroo/screens/user/userHomeScreen.dart';
import 'package:encontroo/screens/user/userLoginScreen.dart';
import 'package:encontroo/screens/user/userProfileScreen.dart';
import 'package:encontroo/screens/user/userSubscriptionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:encontroo/screens/userSelectScreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/userSelect',
      routes: [
        GoRoute(
          path: '/userSelect',
          builder: (context, state) => const UserSelectScreen(),
        ),
        GoRoute(
          path: '/userLogin',
          builder: (context, state) => Userloginscreen(),
        ),
        GoRoute(
          path: '/promLogin',
          builder: (context, state) => PromLoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: '/promHome',
          builder: (context, state) => PromHomeScreen(),
        ),
        GoRoute(
          path: '/promEventDetail',
          builder: (context, state) {
            final extra = state.extra
                as Map<String, dynamic>; // Pegando os dados passados
            return EventDetailScreen(
              activeTab: extra['activeTab'] ??
                  0, // Adicionando activeTab com valor padrão
              imageUrl: extra['imageUrl'] ?? '',
              title: extra['title'] ?? '',
              interestedCount: extra['interestedCount'] ?? 0,
              date: extra['date'] ?? '',
              description: extra['description'] ?? '',
              location: extra['location'] ?? '',
              price: extra['price'] ?? '',
            );
          },
        ),
        GoRoute(
          path: '/editEvent',
          builder: (context, state) {
            final event = state.extra as Map<String,
                dynamic>; // Recupera o `event` passado no contexto.
            return EditEventScreen(event: event); // Passa o evento para a tela.
          },
        ),
        GoRoute(
          path: '/createEvent',
          builder: (context, state) => const CreateEventScreen(),
        ),
        GoRoute(
          path: '/promProfile',
          builder: (context, state) => const PromProfileScreen(),
        ),
        GoRoute(
          path: '/promEditProfile',
          builder: (context, state) => const PromEditProfileScreen(),
        ),
        GoRoute(
          path: '/userEvents',
          builder: (context, state) => const UserEventsScreen(),
        ),
        GoRoute(
          path: '/userHome',
          builder: (context, state) => const UserHomeScreen(),
        ),
        GoRoute(
          path: '/userEventDetail',
          builder: (context, state) {
            final extra = state.extra
                as Map<String, dynamic>; // Pegando os dados passados
            return UserEventDetailScreen(
              imageUrls: extra['imageUrls'] ?? [],
              title: extra['title'] ?? '',
              organizer: extra['organizer'] ?? '',
              date: extra['date'] ?? '',
              location: extra['location'] ?? '',
              description: extra['description'] ?? '',
              price: extra['price'] ?? '',
            );
          },
        ),
        GoRoute(
          path: '/userProfile',
          builder: (context, state) => const UserProfileScreen(),
        ),
        GoRoute(
          path: '/userEditProfile',
          builder: (context, state) => const UserEditProfileScreen(),
        ),
        GoRoute(
          path: '/tinderFeed',
          builder: (context, state) => const TinderFeedScreen(),
        ),
        GoRoute(
          path: '/matchs',
          builder: (context, state) => const MatchsScreen(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatScreen(),
        ),GoRoute(
          path: '/userSubscription',
          builder: (context, state) => const SubscriptionScreen(),
        ),
      ],
      errorBuilder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text(
              'Rota não encontrada!',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
          ),
        );
      },
    );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: 'Encontroo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          supportedLocales: const [
            Locale('en', 'US'), // Inglês
            Locale('pt', 'BR'), // Português do Brasil
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
