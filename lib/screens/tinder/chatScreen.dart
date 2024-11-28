import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/components/tinderMainLayout.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exemplo de mensagens
    final List<Map<String, dynamic>> messages = [
      {'isSender': true, 'text': 'Oi! Como você está?', 'time': '12:30 PM'},
      {'isSender': false, 'text': 'Estou bem, e você?', 'time': '12:32 PM'},
      {'isSender': true, 'text': 'Ótimo! Quer marcar algo?', 'time': '12:35 PM'},
      {'isSender': false, 'text': 'Claro! Vamos combinar.', 'time': '12:36 PM'},
    ];

    return TinderMainLayout(
      activeTab: null, // Sem rodapé nessa tela
      hideFooter: true, // Ocultando o rodapé
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Fecha o teclado ao tocar fora
        },
        child: Column(
          children: [
            // Cabeçalho com avatar e nome
            Padding(
              padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w, bottom: 16.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: AssetImage('assets/googleicon.png'), // Exemplo de imagem
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Alice',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Linha divisória ajustada
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.5),
              height: 1.h,
            ),
            // Corpo das mensagens
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  reverse: true, // Mensagens mais recentes no final
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessageBubble(
                      text: message['text']!,
                      isSender: message['isSender']!,
                      time: message['time']!,
                    );
                  },
                ),
              ),
            ),
            // Campo de texto para enviar mensagens
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Focus(
                      autofocus: true,
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                          print("Campo de texto recebeu foco");
                        }
                      },
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Digite uma mensagem...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white, size: 24.sp),
                    onPressed: () {
                      // Ação ao enviar mensagem
                      print('Mensagem enviada');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir os balões de mensagem
  Widget _buildMessageBubble({
    required String text,
    required bool isSender,
    required String time,
  }) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 0.75.sw), // Largura máxima do balão
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isSender ? const Color(0xFF6B09B5) : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
              bottomLeft: isSender ? Radius.circular(12.r) : Radius.circular(0),
              bottomRight: isSender ? Radius.circular(0) : Radius.circular(12.r),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isSender ? Colors.white : Colors.white70,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                time,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
