import 'package:flutter/material.dart';
import 'Bikeimguploadpage.dart';
import 'cityfiled.dart';

class BikeDetailsStep extends StatefulWidget {
  const BikeDetailsStep({super.key});

  @override
  State<BikeDetailsStep> createState() => _BikeDetailsStepState();
}

class _BikeDetailsStepState extends State<BikeDetailsStep> {
  final _formKey = GlobalKey<FormState>();

  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final engineController = TextEditingController();
  final mileageController = TextEditingController();
  String? fuelType;
  final regNumberController = TextEditingController();
  final regYearController = TextEditingController();
  final kmDrivenController = TextEditingController();
  final ownerController = TextEditingController();
  final cityController = TextEditingController();
  final FocusNode cityFocus = FocusNode();
  final priceController = TextEditingController();

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    engineController.dispose();
    mileageController.dispose();
    regNumberController.dispose();
    regYearController.dispose();
    kmDrivenController.dispose();
    ownerController.dispose();
    cityController.dispose();
    priceController.dispose();
    cityFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Bike Details",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepHeader(),
              SizedBox(height: h*0.022),
              _sectionTitle("Bike Information"),
              _label("Brand"),
              _textField(brandController, "Eg. Yamaha"),
              _label("Model"),
              _textField(modelController, "Eg. R15 V4"),
              _label("Engine CC"),
              _numberField(engineController, "Eg. 155"),
              _label("Mileage (kmpl)"),
              _numberField(mileageController, "Eg. 45"),
              _label("Fuel Type"),
              _fuelDropdown(),
              SizedBox(height: h*0.022),
              _sectionTitle("Registration Details"),
              _label("Registration Number"),
              _textField(regNumberController, "Eg. UP32 AB 1234"),
              _label("Registration Year"),
              GestureDetector(
                onTap: () => pickRegistrationYear(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: regYearController,
                    decoration: _decoration("Select registration year").copyWith(
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    validator: (v) =>
                    v == null || v.isEmpty ? "Select registration year" : null,
                  ),
                ),
              ),

              _label("KM Driven"),
              _numberField(kmDrivenController, "Eg. 15000"),
              _label("Number of Owners"),
              _numberField(ownerController, "Eg. 1"),
              SizedBox(height: h*0.022),
              _sectionTitle("Location"),
              CityAutoCompleteField(
                controller: cityController,
                focusNode: cityFocus,
              ),

              SizedBox(height: h*0.022),
              _sectionTitle("Expected Price"),
              _label("Asking Price"),
              _numberField(priceController, "Eg. 180000"),
              SizedBox(height: h*0.027),
              SizedBox(
                width: double.infinity,
                height: h*0.055,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        cityController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BikeImgUploadPage(
                            bikeDetails: {
                              "brand": brandController.text,
                              "model": modelController.text,
                              "fuel": fuelType ?? "",
                              "engine": engineController.text,
                              "mileage": mileageController.text,
                              "regNo": regNumberController.text,
                              "regYear": regYearController.text,
                              "km": kmDrivenController.text,
                              "owner": ownerController.text,
                              "city": cityController.text,
                              "price": priceController.text,
                            },
                          ),
                        ),
                      );

                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: w*0.048,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepHeader() {
    return Builder(
      builder: (context) {
        final h = MediaQuery.of(context).size.height;
        final w = MediaQuery.of(context).size.width;

        return Container(
          padding: EdgeInsets.all(w * 0.030), // 14
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.08),
            borderRadius: BorderRadius.circular(w * 0.030), // 14
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: w * 0.031, // 14
                backgroundColor: Colors.purple,
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.035,
                  ),
                ),
              ),
              SizedBox(width: w * 0.026),
              Text(
                "Step 1 of 3 · Bike Details",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: w * 0.033,
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  Widget _sectionTitle(String text) {
    return Builder(
      builder: (context) {
        final w = MediaQuery.of(context).size.width;

        return Padding(
          padding: EdgeInsets.only(bottom: w * 0.027), // 12
          child: Text(
            text,
            style: TextStyle(
              fontSize: w * 0.040, // 16
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }


  Widget _label(String text) {
    return Builder(
      builder: (context) {
        final w = MediaQuery.of(context).size.width;

        return Padding(
          padding: EdgeInsets.only(bottom: w * 0.015), // 6
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: w * 0.030, // 13
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }


  Widget _textField(TextEditingController controller, String hint) {
    return Builder(
      builder: (context) {
        final w = MediaQuery.of(context).size.width;

        return Padding(
          padding: EdgeInsets.only(bottom: w * 0.035), // 14
          child: TextFormField(
            controller: controller,
            decoration: _decoration(hint),
            validator: (v) =>
            v == null || v.trim().isEmpty ? "Required" : null,
          ),
        );
      },
    );
  }


  Widget _numberField(TextEditingController controller, String hint) {
    return Builder(
      builder: (context) {
        final w = MediaQuery.of(context).size.width;

        return Padding(
          padding: EdgeInsets.only(bottom: w * 0.035), // 14
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: _decoration(hint),
            validator: (v) {
              if (v == null || v.isEmpty) return "Required";
              if (int.tryParse(v) == null) return "Enter valid number";
              return null;
            },
          ),
        );
      },
    );
  }


  Widget _fuelDropdown() {
    return Builder(
      builder: (context) {
        final w = MediaQuery.of(context).size.width;

        return Padding(
          padding: EdgeInsets.only(bottom: w * 0.032),
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            value: fuelType,
            decoration: _decoration("Select fuel type"),
            items: const ["Petrol", "Electric"]
                .map(
                  (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(fontSize: w * 0.036),
                ),
              ),
            )
                .toList(),
            onChanged: (v) => setState(() => fuelType = v),
            validator: (v) => v == null ? "Required" : null,
          ),
        );
      },
    );
  }



  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> pickRegistrationYear(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        regYearController.text = pickedDate.year.toString();
      });
    }
  }

}


