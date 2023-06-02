
import 'package:flutter/material.dart';
import 'package:input_assets_proj/category/models/category_model.dart';

class CategoryScreen extends StatefulWidget {
   const CategoryScreen({Key? key}) : super(key: key);

   
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController titleTextEditing = TextEditingController();
  final TextEditingController idTextEditing = TextEditingController();
  String parentValue = '';
  String dataTypeValue = '';
  String unitValue = '';


  List<CategoryModel> categoryModelList = [];
  List<String> propertyTestList = [];
  List<String> unitPropertyTestList = [];

  List<String> parentList = ['ندارد','ماشین آلات صنعتی','ماشین آلات کشاورزی'];
  List<String> dataTypeList = ['وزن', 'رنگ', 'قدرت'];
  List<String> weightList = ['کیلوگرم','تن'];
  List<String> colorList = ['آبی','قرمز','زرد'];
  List<String> powerList = ['ژول', 'اسب بخار'];

  int indexParentList = 0 ;
  int indexDataTypeList = 0;
  int indexWeightList = 0;
  int indexColorList = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'عنوان دسته بندی'
                ),
                controller:  titleTextEditing,
              ),
              TextField(
                controller:  idTextEditing,
              ),

              // CategoryType DropDown
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                        BorderSide(color: Colors.grey, width: 1.0))),
                hint: const Text('دسته بندی بر اساس'),
                selectedItemBuilder: (final context) =>
                    parentList.map((e) => Text(e.toString())).toList(),
                items: parentList
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString()),
                )).toList(),
                onChanged: (final value) {
                  if(value == parentList[0]){
                    indexParentList = 1;
                  }else if (value == parentList[1]){
                    indexParentList = 2;
                  }else if (value == parentList[2]){
                    indexParentList = 3;
                  }
                  print(indexParentList.toString());
                },
              ),

              // DataType DropDown
              dataTypeChoice(),

              // Unit DropDown
              unitChoice(),

              ElevatedButton(onPressed: () {
                setState(() {
                  propertyTestList.add(dataTypeValue);
                  unitPropertyTestList.add(unitValue);
                });
                print('${propertyTestList[0].toString()} && ${unitPropertyTestList[0]}');
              }, child: const Text('ثبت ویژگی')),

              ElevatedButton(onPressed: () {
              setState(() {

                parentList.add(titleTextEditing.text.toString());

                categoryModelList.add(CategoryModel(
                    id: 1,
                    title: titleTextEditing.text.toString(),
                    categoryParent: 0,
                    property: propertyTestList,
                    unitProperty: unitPropertyTestList));

              });

              }, child: const Text('ثبت دسته بندی')),

              //Property list
              SizedBox(
                width: double.infinity,
                  height: 100,
                  child:ListView.builder(
                  itemCount: propertyTestList.length,
                  itemBuilder: (context, index) {
                  return  Padding(padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.greenAccent
                      ),
                      child:  Text('ویژگی ها :${propertyTestList[index]} --> ${unitPropertyTestList[index]}'),
                    ),
                  );
                },),
              ),

              const SizedBox(height: 10,),

              //Category List
              SizedBox(
                width: double.infinity,
                height: 100,
                child:ListView.builder(
                  itemCount: categoryModelList.length,
                  itemBuilder: (context, index) {
                    return  Padding(padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.greenAccent
                        ),
                        child:  Text('دسته بندی :${categoryModelList[index].title} -- ${categoryModelList[index].property} -- ${categoryModelList[index].unitProperty}'),
                      ),
                    );
                  },),
              ),


            ],
          ),
        )
      ),
    );
  }

  DropdownButtonFormField<Object?> unitChoice() {
    return DropdownButtonFormField(
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                      BorderSide(color: Colors.grey, width: 1.0))),
              hint: const Text('واحد'),
              selectedItemBuilder:(context) {
                if(indexDataTypeList == 1){
                  return weightList.map((e) => Text(e.toString())).toList();
                }else if(indexDataTypeList == 2){
                  return colorList.map((e) => Text(e.toString())).toList();
                }else if(indexDataTypeList == 3){
                  powerList.map((e) => Text(e.toString())).toList();
                }
                return [];
              },
              items:indexDataTypeList == 1 ?
              weightList.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()),)).toList()
                  :indexDataTypeList ==2 ?
              colorList.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()),)).toList()
                  :indexDataTypeList == 3 ?
              powerList.map((e) =>DropdownMenuItem(value: e, child: Text(e.toString()),)).toList():[],
              onChanged: (value) {
                 unitValue = value.toString();
              },

            );
  }

  DropdownButtonFormField<String> dataTypeChoice() {
    return DropdownButtonFormField(
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                      BorderSide(color: Colors.grey, width: 1.0))),
              hint: const Text('نوع داده'),
              selectedItemBuilder: (final context) =>
                  dataTypeList.map((e) => Text(e.toString())).toList(),
              items: dataTypeList.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()),)).toList(),
              onChanged: (final value) {
                if(value == dataTypeList[0]){
                  setState(() {
                    indexDataTypeList = 1;
                  });
                }else if(value == dataTypeList[1]){
                  setState(() {
                    indexDataTypeList = 2;
                  });
                }else if(value == dataTypeList[2]){
                  setState(() {
                    indexDataTypeList = 3;
                  });
                }
                dataTypeValue = value!;
              },
            );
  }
}
