import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:encontroo/utils/validators.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({Key? key}) : super(key: key);

  @override
  _UserEditProfileScreenState createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
                colors: [Color(0xFFFF7825), Color(0xFF6B09B5)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                            context.go('/userProfile');
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
                SizedBox(height: 20.h),
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
                            radius: 70.r,
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
                              'Adicionar Imagem de perfil',
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
                          _buildLabeledTextField(
                            'Nome',
                            nameController,
                            (value) => Validators.validateRequired(value, 'Nome'),
                          ),
                          _buildDropdownField(
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
                          _buildDropdownField(
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
                          _buildLabeledTextField(
                            'Endereço',
                            addressController,
                            (value) => Validators.validateRequired(value, 'Endereço'),
                          ),
                          _buildMultilineTextField(
                            'Descrição',
                            descriptionController,
                            (value) => Validators.validateRequired(value, 'Descrição'),
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
                                backgroundColor: const Color(0xFFFF7825), // Cor laranja
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
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledTextField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            hintText: 'Digite seu $label',
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
          ),
          style: TextStyle(color: Colors.black, fontSize: 12.sp),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildMultilineTextField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          maxLines: 3,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            hintText: 'Digite sua $label',
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
          ),
          style: TextStyle(color: Colors.black, fontSize: 12.sp),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String? selectedValue,
    String? Function(String?) validator,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        DropdownButtonFormField<String>(
          initialValue: selectedValue,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
