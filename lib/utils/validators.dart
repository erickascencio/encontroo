import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Validators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório.';
    }

    final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um email válido.';
    }
    return null;
  }

  static String? validateCPF(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'CPF é obrigatório.';
    }

    // Remove a máscara para validação
    final rawValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawValue.length != 11) {
      return 'CPF deve conter 11 dígitos.';
    }

    // Validação avançada (verificador de dígitos)
    if (!_isValidCPF(rawValue)) {
      return 'CPF inválido.';
    }

    return null;
  }

  static bool _isValidCPF(String cpf) {
    if (cpf.length != 11 || RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    List<int> numbers = cpf.split('').map(int.parse).toList();

    int calculateVerifierDigit(List<int> digits, int length) {
      int sum = 0;
      for (int i = 0; i < length; i++) {
        sum += digits[i] * ((length + 1) - i);
      }
      int mod = sum % 11;
      return mod < 2 ? 0 : 11 - mod;
    }

    int firstDigit = calculateVerifierDigit(numbers, 9);
    int secondDigit = calculateVerifierDigit(numbers, 10);

    return firstDigit == numbers[9] && secondDigit == numbers[10];
  }

  static String? validateCNPJ(String? value, MaskTextInputFormatter formatter) {
    final unmaskedValue = formatter.getUnmaskedText();
    if (unmaskedValue.length != 14) {
      return 'CNPJ deve conter 14 dígitos.';
    }
    // Lógica adicional para validar CNPJ.
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Telefone é obrigatório.';
    }

    // Remove a máscara para validação
    final rawValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawValue.length != 11) {
      return 'Telefone deve conter 11 dígitos (incluindo DDD).';
    }
    return null;
  }

  

static String? validateDateOfBirth(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Data de nascimento é obrigatória.';
  }

  try {
    // Valida o formato antes de fazer o parse
    final format = DateFormat('dd/MM/yyyy');
    final date = format.parseStrict(value); // Usa parseStrict para maior segurança

    final now = DateTime.now();

    // Verifica se a pessoa tem mais de 18 anos
    if (date.isAfter(now.subtract(const Duration(days: 6570)))) {
      return 'Você deve ter mais de 18 anos.';
    }
  } catch (e) {
    return 'Formato de data inválido. Use dd/MM/yyyy.';
  }
  return null;
}

}
