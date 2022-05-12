import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx/pages/new_announcement/new_announcement_model.dart';
import '../../components/textfield_component.dart';

class NewAnnouncementsTextFormFields extends StatefulWidget {
  final NewAnnouncementModel newAnnouncementModel;
  const NewAnnouncementsTextFormFields({
    required this.newAnnouncementModel,
    Key? key,
  }) : super(key: key);

  @override
  State<NewAnnouncementsTextFormFields> createState() =>
      _NewAnnouncementsTextFormFieldsState();
}

class _NewAnnouncementsTextFormFieldsState
    extends State<NewAnnouncementsTextFormFields> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldComponent(
          onChanged: (value) {
            widget.newAnnouncementModel.name = _nameController.text;
          },
          label: 'Nome',
          textEditingController: _nameController,
          enabled: true,
          textInputFormatter: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          validator: (value) {
            if (value!.isEmpty) {
              print('nulo');
              return 'Digite o nome!';
            }
          },
        ),
        const SizedBox(height: 10),
        TextFieldComponent(
          onChanged: (value) {
            widget.newAnnouncementModel.price = _priceController.text;
          },
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
              return 'Digite um valor!';
            }
          },
        ),
        const SizedBox(height: 10),
        TextFieldComponent(
          onChanged: (value) {
            widget.newAnnouncementModel.phoneNumber = _numberController.text;
          },
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
              return 'Digite um número válido!';
            } else if (value.length < 14) {
              return 'Digite o número completo';
            }
          },
        ),
        const SizedBox(height: 10),
        TextFieldComponent(
          onChanged: (value) {
            widget.newAnnouncementModel.description =
                _descriptionController.text;
          },
          maxLength: 200,
          maxLines: 4,
          label: 'Descrição',
          textEditingController: _descriptionController,
          enabled: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Digite uma descrição!';
            } else if (value.length < 10) {
              return 'DIgite pelo menos 10 caracteres';
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
