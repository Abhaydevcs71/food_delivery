import 'package:admin_web_panel/global/global_ins.dart';
import 'package:admin_web_panel/global/global_vars.dart';
import 'package:admin_web_panel/views/widgets/category_list.dart';
import 'package:admin_web_panel/views/widgets/my_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleMsg: "Upload Category", showBackButton: true,),
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
                      SizedBox(height: 20,),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          onChanged: (valueText) {
                            categoryName = valueText;
                          },
                          validator: (valueText){
                            if(valueText!.isEmpty){
                              return "Please fill Category Name";
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Enter the category Name")
                          ),
                        ),
                      ),
                      const SizedBox(width: 40,),
                       ElevatedButton(onPressed: ()async {
          
                       if(formKey.currentState!.validate()){
                        if(imageFile != null && categoryName.isNotEmpty){
                           commonViewModel.showSnackBar("Uploading Category..", context);
                       await categoryViewModel.saveCategoryInfoToFirestore();
                       setState(() {
                         formKey.currentState!.reset();
                       imageFile = null;
                       categoryName = "";
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
              //display category
          
              Container(alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text("Uplaod Category List",
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
              ),
              ),
              const SizedBox(height: 16,),
              const CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}