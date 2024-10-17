import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  // Define static exchange rates
  Map<String, double> exchangeRates = {
    'USD': 1.0,
    'PKR': 277.65,
    'EUR': 0.94,
    'GBP': 0.82,
    'JPY': 149.0,
    'INR': 83.2,
    'CNY': 7.3,
  };

  String selectedCurrency1 = 'USD'; // Default selected input currency
  String selectedCurrency2 = 'PKR'; // Default selected output currency

  // Function to perform the currency conversion
  double convertCurrency(
      String fromCurrency, String toCurrency, double amount) {
    double fromRate = exchangeRates[fromCurrency]!;
    double toRate = exchangeRates[toCurrency]!;

    double usdAmount = amount / fromRate; // Convert to base (USD)
    return usdAmount * toRate; // Convert to target currency
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.circular(16),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFC8E1CC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8E1CC),
        title: const Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$selectedCurrency2 : ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFF121212),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(6),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Please enter the amount in $selectedCurrency1",
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            // Dropdown for selecting the input currency
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.all(12),
              child: DropdownButton<String>(
                value: selectedCurrency1,
                onChanged: (newValue) {
                  setState(() {
                    selectedCurrency1 = newValue!;
                  });
                },
                items: exchangeRates.keys.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                isExpanded: true,
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),

            // Dropdown for selecting the output currency
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.all(12),
              child: DropdownButton<String>(
                value: selectedCurrency2,
                onChanged: (newValue) {
                  setState(() {
                    selectedCurrency2 = newValue!;
                  });
                },
                items: exchangeRates.keys.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                isExpanded: true,
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(2),
              child: TextButton(
                onPressed: () {
                  double amount =
                      double.tryParse(textEditingController.text) ?? 0;
                  setState(() {
                    result = convertCurrency(
                        selectedCurrency1, selectedCurrency2, amount);
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF121212),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(490, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
