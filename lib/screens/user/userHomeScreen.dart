import 'package:encontroo/components/homeCard.dart'; // Importa o componente HomeCard
import 'package:encontroo/components/userMainLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de eventos (exemplo)
    final List<Map<String, dynamic>> events = [
      {
        'imageUrls': [
          'assets/logoencontro.png',
          'assets/example_image.png',
        ], // URLs das imagens
        'title': 'Evento 1',
        'organizer': 'Empresa 1',
        'date': '28/12/2024',
        'location': 'Guarapuava, PR',
        'description': 'Descrição do evento 1. Detalhes importantes aqui.',
      },
      {
        'imageUrls': [
          'assets/logoencontro.png',
        ],
        'title': 'Evento 2',
        'organizer': 'Empresa 2',
        'date': '15/01/2025',
        'location': 'Curitiba, PR',
        'description': 'Descrição do evento 2. Detalhes importantes aqui.',
      },
      {
        'imageUrls': [
          'assets/logoencontro.png',
          'assets/example_image.png',
        ],
        'title': 'Evento 3',
        'organizer': 'Empresa 3',
        'date': '10/11/2024',
        'location': 'Ponta Grossa, PR',
        'description': 'Descrição do evento 3. Detalhes importantes aqui.',
      },
    ];

    return UserMainLayout(
      activeTab: 0, // Aba ativa (Eventos)
      title: 'Eventos', // Título do cabeçalho
      body: Column(
        children: [
          // Barra de pesquisa
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Container(
              height: 36.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Procurar Evento',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12.sp,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 10.h),
                ),
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ),
          // Lista de cards
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return HomeCard(
                  imageUrls: event['imageUrls'], // Passa a lista de imagens
                  title: event['title'],
                  organizer: event['organizer'],
                  date: event['date'],
                  location: event['location'],
                  description: event['description'],
                  onTap: () {
                    context.push(
                      '/userEventDetail',
                      extra: {
                        'imageUrls': [
                          'assets/image1.png',
                          'assets/image2.png'
                        ], // Lista de imagens
                        'title': 'Evento 1',
                        'organizer': 'Empresa Organizadora',
                        'date': '25/12/2024',
                        'location': 'Rua, Simeão Varela de sá,32 - Guarapuava, PR',
                        'description': 'Descrição completa do evento. Descrição completa do evento. Descrição completa do evento. Descrição completa do evento. Descrição completa do evento. Descrição completa do evento. Descrição completa do evento. Descrição completa do evento. Descrição completa do evento. ',
                        'price': 'R\$ 50,00',
                      },
                    );
                    print('Clicou em "${event['title']}"');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
