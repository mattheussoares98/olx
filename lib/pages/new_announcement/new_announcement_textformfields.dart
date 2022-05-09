import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/textfield_component.dart';

class NewAnnouncementsTextFormFields extends StatefulWidget {
  const NewAnnouncementsTextFormFields({Key? key}) : super(key: key);

  @override
  State<NewAnnouncementsTextFormFields> createState() =>
      _NewAnnouncementsTextFormFieldsState();
}

class _NewAnnouncementsTextFormFieldsState
    extends State<NewAnnouncementsTextFormFields> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldComponent(
          label: 'Nome',
          textEditingController: _nameController,
          enabled: true,
          textInputFormatter: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          validator: (value) {
            if (value!.isEmpty) {
              print('nulo');
              return 'Digite um valor!';
            }
          },
        ),
        const SizedBox(height: 10),
        TextFieldComponent(
          label: 'Preço',
          textEditingController: _priceController,
          enabled: true,
          textInputType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            CentavosInputFormatter(moeda: true, casasDecimais: 2),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              print('nulo');
              return 'Digite um valor!';
            }
          },
        ),
        const SizedBox(height: 10),
        TextFieldComponent(
          maxLength: 15,
          label: 'Telefone',
          textEditingController: _numberController,
          enabled: true,
          textInputType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter(),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              print('nulo');
              return 'Digite um valor!';
            } else if (value.length < 14) {
              return 'Digite o número completo';
            }
          },
        ),
        const SizedBox(height: 10),
        TextFieldComponent(
          maxLength: 200,
          maxLines: 4,
          label: 'Descrição',
          textEditingController: _descriptionController,
          enabled: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Digite um valor!';
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
