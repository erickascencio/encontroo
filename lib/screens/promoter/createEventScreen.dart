import 'package:encontroo/components/eventForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

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
            Container(color: Colors.white.withOpacity(0.5)),
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
                        "Criar Evento",
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
                      imageUrl: null,
                      title: null,
                      dateTime: null, // Atualizado para 'dateTime'
                      description: null,
                      location: null,
                      price: null,
                      onSave: () {
                        print('Criando novo evento');
                      },
                      onImageChange: () {
                        print('Selecionando imagem para novo evento');
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
