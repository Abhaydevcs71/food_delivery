import 'package:admin_web_panel/global/global_ins.dart';
import 'package:admin_web_panel/global/global_vars.dart';
import 'package:admin_web_panel/views/widgets/banners_list.dart';
import 'package:admin_web_panel/views/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "Upload Banners", showBackButton: true,),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                children: [
                  const Divider(
                    color: Colors.purple,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
          
          
                          //display image
                          Container(
                            height: 140,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade800),
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: imageFile != null ? Image.memory(imageFile) : Container(),
                            ),
                          ),
                          const SizedBox(height: 10,),
                      ElevatedButton(onPressed: () async{
                         await commonViewModel.pickImage();
                        setState(() {
                          imageFile;
                          fileName;
                        });
                      }, child: const Text("Pick Image",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ))
                        ],
                      ),
                      ),
                      const SizedBox(width: 40,),
                       ElevatedButton(onPressed: ()async {

                         if(formKey.currentState!.validate()){
                          if(imageFile != null){
                            commonViewModel.showSnackBar("Uploading Banner..", context);
                       await bannerViewModel.saveBannerInfoImageInfoToFirestore();
                       setState(() {
                         formKey.currentState!.reset();
                       imageFile = null;
                       });
                       commonViewModel.showSnackBar("Upload SucessFully", context);
                          }
                         }
          
                        
                      }, child: const Text("Save",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ))
                    ],
                  ),
                  const Divider(
                    color: Colors.purple,
                  ),
                ],
              )),
              //display banners
          
              Container(alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text("Uplaod Banners List",
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
              ),
              ),
              const SizedBox(height: 16,),
              const BannerList(),
            ],
          ),
        ),
      ),
    );
  }
}