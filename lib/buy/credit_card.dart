import 'package:amazon/common/materialb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class Credit extends StatefulWidget {
  const Credit({super.key, required this.function});
  final Function() function;
  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  String bankName = 'Sunrise Bank';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  final formkey = GlobalKey<FormState>();
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
            backgroundNetworkImage:
                "https://img.freepik.com/free-vector/global-network-connection-world-map-digital-background_1017-23322.jpg?w=900&t=st=1688546256~exp=1688546856~hmac=76e4a1f47ff4f971f956e419a53938d3eb95e24f327d0bf104dc7696bfea9134",
            chipColor: const Color(0XFFF2CC00).withOpacity(0.9),
            isHolderNameVisible: true,
            cardType: CardType.visa,
            cardBgColor: Colors.black12,
            bankName: bankName,
            textStyle: const TextStyle(
                color: Colors.white, backgroundColor: Colors.black),
            cardNumber: cardNumber,
            obscureCardNumber: false,
            obscureCardCvv: false,
            obscureInitialCardNumber: false,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: cvvCode.isEmpty ? false : true,
            onCreditCardWidgetChange: (change) {}),
        CreditCardForm(
            cardHolderDecoration: InputDecoration(
                labelText: 'Card holder',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    )),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
            cardNumberDecoration: InputDecoration(
                labelText: 'Card number',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    )),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
            expiryDateDecoration: InputDecoration(
                labelText: 'Expired Date',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    )),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
            cvvCodeDecoration: InputDecoration(
                labelText: 'CVV',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
            obscureCvv: true,
            obscureNumber: true,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: onCreditCardModelChange,
            themeColor: Colors.black,
            formKey: formkey),
        Custommaterialbutton(
            width: double.infinity,
            function: () {
              if (cardNumber.isNotEmpty &&
                  expiryDate.isNotEmpty &&
                  cardHolderName.isNotEmpty &&
                  cvvCode.isNotEmpty) {
                widget.function;
              }
            },
            name: "Make Payment",
            color: const Color(0xFF00E070),
            borderclr: Colors.grey,
            radius: 5),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
