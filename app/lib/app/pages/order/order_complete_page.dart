import 'package:app/app/core/ui/helpers/size_extensions.dart';
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentHeight(0.20),
              ),
              Image.asset('assets/images/logo_rounded.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido.',
                style: context.textStyle.textExtraBold.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              DeliveryButton(
                  width: context.percentWidth(0.80),
                  label: 'FECHAR',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
