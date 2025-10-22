import 'package:encontroo/components/eventForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditEventScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  const EditEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Fundo gradiente
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF6B09B5), Color(0xFFFF7825)],
                ),
              ),
            ),
            // Filtro branco
            Container(color: Colors.white.withValues(alpha: 0.5)),
            Column(
              children: [
                // Cabeçalho com botão de voltar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 20.sp,
                          color: const Color(0xFF6B09B5),
                        ),
                        onPressed: () {
                          if (GoRouter.of(context).canPop()) {
                            context.pop();
                          } else {
                            context.go('/promHome');
                          }
                        },
                      ),
                      Text(
                        "Editar Evento",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 48), // Placeholder
                    ],
                  ),
                ),
                // Formulário com scroll
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: EventForm(
                      imageUrl: event['imageUrl'],
                      title: event['title'],
                      dateTime: event['dateTime'], // Atualizado para 'dateTime'
                      description: event['description'],
                      location: event['location'],
                      price: event['price'],
                      onSave: () {
                        print('Atualizando evento');
                      },
                      onImageChange: () {
                        print('Alterando imagem');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
