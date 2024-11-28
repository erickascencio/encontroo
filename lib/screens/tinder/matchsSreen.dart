import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/components/tinderMainLayout.dart';

class MatchsScreen extends StatelessWidget {
  const MatchsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de matches de exemplo
    final List<Map<String, String>> matches = [
      {'name': 'Alice', 'image': 'assets/alice.jpg'},
      {'name': 'Bob', 'image': 'assets/bob.jpg'},
      {'name': 'Clara', 'image': 'assets/clara.jpg'},
      {'name': 'Daniel', 'image': 'assets/daniel.jpg'},
      {'name': 'Eva', 'image': 'assets/eva.jpg'},
    ];

    // Lista de mensagens
    final List<Map<String, String>> messages = [
      {
        'name': 'Alice',
        'image': 'assets/alice.jpg',
        'lastMessage': 'Oi! Como você está?',
      },
      {
        'name': 'Bob',
        'image': 'assets/bob.jpg',
        'lastMessage': 'Foi ótimo te conhecer!',
      },
      {
        'name': 'Clara',
        'image': 'assets/clara.jpg',
        'lastMessage': 'Vamos marcar algo?',
      },
    ];

    return TinderMainLayout(
      activeTab: 1, // Aba ativa no rodapé
      title: 'Encontroos', // Título do cabeçalho
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de pesquisa
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Buscar matches...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                ),
              ),
            ),

            // Carrossel de avatares
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return _buildAvatar(match);
                },
              ),
            ),

            SizedBox(height: 16.h), // Espaçamento

            // Lista de mensagens
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Text(
                        'Você ainda não tem mensagens!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return _buildMessageCard(message);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para criar o avatar no carrossel
  Widget _buildAvatar(Map<String, String> match) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w), // Espaçamento entre os avatares
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os textos
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(match['image']!),
            radius: 30.r,
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 60.w, // Largura máxima para nomes longos
            child: Text(
              match['name']!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center, // Centraliza o texto
            ),
          ),
        ],
      ),
    );
  }

  // Widget para criar o card de cada mensagem
  Widget _buildMessageCard(Map<String, String> message) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Fundo translúcido
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.w),
        leading: CircleAvatar(
          backgroundImage: AssetImage(message['image']!),
          radius: 28.r,
        ),
        title: Text(
          message['name']!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          message['lastMessage']!,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.chat, color: Colors.white, size: 24.sp),
          onPressed: () {
            // Ação ao clicar no botão de chat
            print('Abrindo chat com ${message['name']}');
          },
        ),
      ),
    );
  }
}
