// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/core/ui/helpers/size_extensions.dart';
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:app/app/models/payment_types_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

class PaymentsTypeField extends StatelessWidget {
  final List<PaymentTypesModel> paymentTypes;
  final ValueChanged<int> valueChanged;
  final bool valid;
  final String valueSelected;

  const PaymentsTypeField({
    super.key,
    required this.paymentTypes,
    required this.valueChanged,
    required this.valid,
    required this.valueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forma de pagamento',
            style: context.textStyle.textRegular.copyWith(
              fontSize: 16,
            ),
          ),
          SmartSelect<String>.single(
            title: '',
            selectedValue: valueSelected,
            modalType: S2ModalType.bottomSheet,
            onChange: (selected) {
              valueChanged(int.parse(selected.value));
            },
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: context.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selected.title ?? '',
                            style: context.textStyle.textRegular,
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: const Divider(
                        color: Colors.red,
                      ),
                    ),
                    Visibility(
                      visible: !valid,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Selecione uma forma de pagamento.',
                          style: context.textStyle.textRegular.copyWith(
                            fontSize: 13,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom<String, Map<String, String>>(
              source: paymentTypes
                  .map((e) => {
                        'value': e.id.toString(),
                        'title': e.name,
                      })
                  .toList(),
              title: (index, item) => item['title'] ?? '',
              value: (index, item) => item['value'] ?? '',
              group: (index, item) => 'Selecione uma forma de pagamento',
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
          )
        ],
      ),
    );
  }
}
