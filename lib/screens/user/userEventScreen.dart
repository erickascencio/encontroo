import 'package:encontroo/components/eventCard.dart';
import 'package:encontroo/components/userMainLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserEventsScreen extends StatelessWidget {
  const UserEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de eventos mockados
    final List<Map<String, dynamic>> events = [
      {
        'imageUrl': 'assets/logoencontro.png',
        'title': 'Evento 1',
        'interestedCount': 78,
        'date': '29/12/2024',
        'description': 'Este é o evento 1. Aqui vai uma breve descrição.',
        'location': 'Rua Simeão Varela de Sá, 32 - Guarapuava, PR',
        'price': '75 R\$',
      },
      {
        'imageUrl': 'assets/googleicon.png',
        'title': 'Evento 2',
        'interestedCount': 120,
        'date': '15/01/2025',
        'description': 'Descrição para o evento 2. Detalhes relevantes.',
        'location': 'Curitiba, PR',
        'price': '100 R\$',
      },
      {
        'imageUrl': null, // Fallback para imagem ausente
        'title': 'Evento 3',
        'interestedCount': 56,
        'date': '10/11/2024',
        'description': 'Descrição do evento 3. Evento aconchegante.',
        'location': 'Ponta Grossa, PR',
        'price': '50 R\$',
      },
    ];

    return UserMainLayout(
      activeTab: 1, // Aba ativa (Eventos)
      title: 'Meus Rolês', // Título do cabeçalho
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
          // Lista de eventos
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  imageUrl: event['imageUrl'],
                  title: event['title'],
                  date: event['date'],
                  location: event['location'],
                  description: event['description'],
                  interestedCount: event['interestedCount'],
                  price: event['price'],
                  onTap: () {
                    // Navegação para a tela de detalhes do evento
                    context.push(
                      '/eventDetail',
                      extra: {
                        'imageUrl': event['imageUrl'] ?? '',
                        'title': event['title'],
                        'interestedCount': event['interestedCount'],
                        'date': event['date'],
                        'description': event['description'],
                        'location': event['location'],
                        'price': event['price'],
                      },
                    );
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
