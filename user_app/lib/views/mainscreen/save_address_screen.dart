


import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_app/constants/app_colors.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/global/global_vars.dart';
import 'package:user_app/widgets/address_text_fiels.dart';

class SaveAddressScreen extends StatefulWidget {
  const SaveAddressScreen({super.key});

  @override
  State<SaveAddressScreen> createState() => _SaveAddressScreenState();
}

class _SaveAddressScreenState extends State<SaveAddressScreen> {

  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;
  Position? position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Address"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended
      
      (onPressed: () async{
        if(formKey.currentState!.validate()){
        await addressViewModel.saveShipmentAddresstoDatabase(
            _name.text.trim(),
            state.text.trim(),
            completeAddress.text.trim(),
            _phoneNumber.text.trim(),
            flatNumber.text.trim(),
            city.text.trim(),
            latitudeValue,
            longitudeValue,
            context,
          );

          formKey.currentState!.reset();
        }
      }, label: const Text("Save"),
      backgroundColor: kBlackColor,
      icon: Icon(Icons.add_location,color: kWhiteColor,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:  [
            const SizedBox(height: 6,),
            ListTile(
              leading: Icon(
                Icons.person_pin_circle,
                color: kBlackColor,
                size: 35,
              ),
              title: SizedBox(width: 250,
              child: TextField(
                style: TextStyle(
                  color: kBlackColor,
                ),
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "What is your address?",
                  hintStyle: TextStyle(
                    color: kBlackColor,
                  )
                ),
              ),
              ),
            ),
            const SizedBox(height: 6,),

            ElevatedButton.icon(onPressed: () async{
             await commonViewModel.getCurrentLocation();
            }, icon: const Icon(Icons.location_on), label: const Text("Get my Location"),
            style: ElevatedButton.styleFrom(
              backgroundColor: kBlackColor,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: kBlackColor)
              )
            ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                AddressTextField(
                  hint: "Name",
                  controller: _name,
                ),
                const SizedBox(height: 10,),
                AddressTextField(
                  hint: "Phone Number",
                  controller: _phoneNumber,
                ),
                const SizedBox(height: 10,),
                AddressTextField(
                  hint: "City",
                  controller: city,
                ),
                const SizedBox(height: 10,),
                AddressTextField(
                  hint: "State",
                  controller: state,
                ),
                const SizedBox(height: 10,),
                AddressTextField(
                  hint: "Address Line",
                  controller: flatNumber,
                ),
                const SizedBox(height: 10,),
                AddressTextField(
                  hint: "Complete Address",
                  controller: completeAddress,
                ),
                const SizedBox(height: 10,),
              ],)),
            )           
          ],
        ),
      ),
    );
  }
}