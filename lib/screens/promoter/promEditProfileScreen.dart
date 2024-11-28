import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:encontroo/utils/validators.dart';
import 'package:encontroo/utils/input_formatters.dart';
import 'package:encontroo/components/buttons.dart';

class PromEditProfileScreen extends StatefulWidget {
  const PromEditProfileScreen({Key? key}) : super(key: key);

  @override
  _PromEditProfileScreenState createState() => _PromEditProfileScreenState();
}

class _PromEditProfileScreenState extends State<PromEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedCity;
  String? selectedState;

  final List<String> cities = ['Guarapuava', 'Curitiba', 'Ponta Grossa'];
  final List<String> states = ['PR', 'SC', 'RS'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botão de Voltar e Título (Cabeçalho com altura reduzida)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 24.sp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (GoRouter.of(context).canPop()) {
                            context.pop();
                          } else {
                            context.go('/promProfile');
                          }
                        },
                      ),
                      Text(
                        'Editar Perfil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48), // Placeholder para alinhar
                    ],
                  ),
                ),
                SizedBox(height: 10.h), // Reduzido para ajustar o cabeçalho
                // Corpo
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Imagem de Perfil
                          CircleAvatar(
                            radius: 70.r, // Aumentado
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.image, size: 50.sp, color: Colors.grey),
                          ),
                          SizedBox(height: 10.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              print('Alterar Imagem de Perfil');
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              size: 16.sp,
                              color: const Color(0xFF6B09B5),
                            ),
                            label: Text(
                              'Alterar Imagem',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD9B3FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              minimumSize: Size(150.w, 36.h),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // Campos de formulário
                          Buttons.buildLabeledTextField(
                            'Nome Responsável Perfil',
                            nameController,
                            (value) => Validators.validateRequired(value, 'Nome'),
                          ),
                          Buttons.buildLabeledTextField(
                            'Email',
                            emailController,
                            Validators.validateEmail,
                          ),
                          Buttons.buildLabeledTextField(
                            'Telefone',
                            phoneController,
                            Validators.validatePhone,
                            inputFormatters: [InputFormatters.phoneFormatter],
                          ),
                          // Dropdown Estado
                          Buttons.buildLabeledDropdownField(
                            context,
                            'Estado',
                            states,
                            selectedState,
                            (value) => Validators.validateRequired(value, 'Estado'),
                            (value) {
                              setState(() {
                                selectedState = value;
                              });
                            },
                          ),
                          // Dropdown Cidade
                          Buttons.buildLabeledDropdownField(
                            context,
                            'Cidade',
                            cities,
                            selectedCity,
                            (value) => Validators.validateRequired(value, 'Cidade'),
                            (value) {
                              setState(() {
                                selectedCity = value;
                              });
                            },
                          ),
                          Buttons.buildLabeledTextField(
                            'Endereço',
                            addressController,
                            (value) => Validators.validateRequired(value, 'Endereço'),
                          ),
                          SizedBox(height: 20.h),
                          // Botão de Finalizar
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('Perfil atualizado com sucesso!');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B09B5), // Cor ajustada
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                minimumSize: Size(150.w, 40.h),
                              ),
                              icon: Icon(
                                Icons.check_box_outlined,
                                size: 18.sp,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Finalizar',
                                style: TextStyle(fontSize: 14.sp, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h), // Espaço antes do rodapé invisível
                        ],
                      ),
                    ),
                  ),
                ),
                // Rodapé Invisível
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
