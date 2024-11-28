import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/utils/validators.dart';
import 'package:encontroo/components/buttons.dart';
import 'package:encontroo/utils/input_formatters.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave do Formulário
  bool isPJSelected = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fantasyNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  String? selectedCity;
  String? selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Cadastro',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF7825),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF7825), // Laranja
                  Color(0xFF6B09B5), // Roxo
                ],
              ),
            ),
          ),
          // White Overlay with Proper Opacity
          Container(
            color: Colors.white
                .withOpacity(0.6), // Ajustado para melhor visibilidade
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Form(
              key: _formKey, // Chave do formulário
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botões de seleção PJ e PF reduzidos
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPJSelected = true;
                            });
                          },
                          child: Container(
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: isPJSelected
                                  ? const Color(0xFF6B09B5)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                bottomLeft: Radius.circular(30.r),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isPJSelected)
                                  const Icon(Icons.check,
                                      color: Colors.white, size: 14),
                                SizedBox(width: isPJSelected ? 4.w : 0),
                                Text(
                                  'PJ',
                                  style: TextStyle(
                                    color: isPJSelected
                                        ? Colors.white
                                        : const Color(0xFF6B09B5),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPJSelected = false;
                            });
                          },
                          child: Container(
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: !isPJSelected
                                  ? const Color(0xFF6B09B5)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.r),
                                bottomRight: Radius.circular(30.r),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isPJSelected)
                                  const Icon(Icons.check,
                                      color: Colors.white, size: 14),
                                SizedBox(width: !isPJSelected ? 4.w : 0),
                                Text(
                                  'PF',
                                  style: TextStyle(
                                    color: !isPJSelected
                                        ? Colors.white
                                        : const Color(0xFF6B09B5),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Campos de texto específicos para PJ ou PF
                  isPJSelected
                      ? Column(
                          children: [
                            Buttons.buildLabeledTextField(
                              'Nome Responsável Perfil',
                              nameController,
                              (value) => Validators.validateRequired(
                                  value, 'Nome Responsável Perfil'),
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
                            Buttons.buildLabeledTextField(
                              'CNPJ',
                              cnpjController,
                              (value) => Validators.validateCNPJ(
                                  value, InputFormatters.cnpjFormatter),
                              inputFormatters: [InputFormatters.cnpjFormatter],
                            ),
                            Buttons.buildLabeledDropdownField(
                              context,
                              'Cidade',
                              ['Cidade 1', 'Cidade 2', 'Cidade 3'],
                              selectedCity,
                              (value) =>
                                  Validators.validateRequired(value, 'Cidade'),
                              (value) => setState(() {
                                selectedCity = value;
                              }),
                            ),
                            Buttons.buildLabeledDropdownField(
                              context,
                              'Estado',
                              ['Estado 1', 'Estado 2', 'Estado 3'],
                              selectedState,
                              (value) =>
                                  Validators.validateRequired(value, 'Estado'),
                              (value) => setState(() {
                                selectedState = value;
                              }),
                            ),
                            Buttons.buildLabeledTextField(
                              'Endereço',
                              addressController,
                              (value) => Validators.validateRequired(
                                  value, 'Endereço'),
                            ),
                            Buttons.buildLabeledTextField(
                              'Nome Fantasia',
                              fantasyNameController,
                              (value) => Validators.validateRequired(
                                  value, 'Nome Fantasia'),
                              suffixIcon: const Icon(
                                Icons.info,
                                color: Color(0xFF6B09B5),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Buttons.buildLabeledTextField(
                              'Nome Completo',
                              nameController,
                              (value) => Validators.validateRequired(
                                  value, 'Nome Completo'),
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
                            Buttons.buildLabeledTextField(
                              'CPF',
                              cpfController,
                              Validators.validateCPF,
                              inputFormatters: [InputFormatters.cpfFormatter],
                            ),
                            Buttons.buildLabeledDropdownField(
                              context,
                              'Cidade',
                              ['Cidade 1', 'Cidade 2', 'Cidade 3'],
                              selectedCity,
                              (value) =>
                                  Validators.validateRequired(value, 'Cidade'),
                              (value) => setState(() {
                                selectedCity = value;
                              }),
                            ),
                            Buttons.buildLabeledDropdownField(
                              context,
                              'Estado',
                              ['Estado 1', 'Estado 2', 'Estado 3'],
                              selectedState,
                              (value) =>
                                  Validators.validateRequired(value, 'Estado'),
                              (value) => setState(() {
                                selectedState = value;
                              }),
                            ),
                            Buttons.buildLabeledTextField(
                              'Endereço',
                              addressController,
                              (value) => Validators.validateRequired(
                                  value, 'Endereço'),
                            ),
                            Buttons.buildLabeledDatePickerField(
                              context,
                              'Data de Nascimento',
                              birthDateController,
                            ),
                          ],
                        ),

                  // Botão Finalizar
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 180.w,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF7825), // Laranja
                              Color(0xFF6B09B5), // Roxo
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Cadastro realizado com sucesso!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Text(
                            'Finalizar',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
