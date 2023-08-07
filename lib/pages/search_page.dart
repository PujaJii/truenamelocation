import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/search_number_controller.dart';

import '../styles/app_colors.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TextEditingController controller = TextEditingController();
    var resNumber = 'number'.obs;
    TextEditingController number = TextEditingController();

    SearchNumberController searchNumberController = Get.put(SearchNumberController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white ,
        body: Obx(
            ()=> Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 50,
                  child: CupertinoSearchTextField(
                    padding: const EdgeInsets.all(8),
                    controller: number,
                    onChanged: (value) {
                     // print('onChanged $value');
                      searchNumberController.search(value);
                     // print('TEC val ${number.text}');
                     // print(value);
                    //  print(searchNumberController.listMyContact.length);
                     // print(searchNumberController.listTrueResult.length);
                      value.toString() == ''?
                      resNumber.value ='number':
                      resNumber.value = value;
                    },
                    onSubmitted: (value) {
                    //  print('onSubmitted $value');
                      searchNumberController.searchOnSubmit(context,value);
                    },
                    autocorrect: true,
                  ),
                ),
              ),
              Text('Search by $resNumber...',overflow: TextOverflow.ellipsis),
              Expanded(
                child: GetX<SearchNumberController>(initState: (context) {
                  searchNumberController.search(number.text);
                  // profileUpdateController.getLocation();
                }, builder: (controller) {
                  if (controller.isLoading.value) {

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return controller.listMyContact.isNotEmpty?
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text('Contact', style: TextStyle( fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                            child: ListView.builder(
                              itemCount: searchNumberController.list[0].myContact!.length
                              //     <3?
                              // searchNumberController.list[0].myContact!.length : 3
                              ,
                              itemBuilder: (context, index) {
                                //print('list of myContact${searchNumberController.listMyContact.length}');
                                return ListTile(
                                  leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColors.colors[index % AppColors.colors.length],
                                      ),
                                      child:  Center(
                                          child: Text(controller.list[0].myContact![index].name.toString().substring(0,1),
                                              style: TextStyle(
                                                  color: AppColors.colors2[index % AppColors.colors2.length], fontSize: 20)))),
                                  title: Text(controller.list[0].myContact![index].name.toString()),
                                  subtitle: Text(controller.list[0].myContact![index].mobile.toString()),
                                );
                              },
                            )
                        ),
                        // SizedBox(height: 10,),
                        // Divider(),
                        // Row(
                        //   children: [
                        //     SizedBox(width: 20,),
                        //     Text('Global', style: TextStyle( fontWeight: FontWeight.bold)),
                        //   ],
                        // ),
                        // SizedBox(height: 10,),
                        // Expanded(
                        //     child: ListView.builder(
                        //       itemCount: searchNumberController.list[0].trueCaller!.length < 3?
                        //       searchNumberController.list[0].trueCaller!.length : 3,
                        //       itemBuilder: (context, index) {
                        //         //print('list of myContact${searchNumberController.listMyContact.length}');
                        //         return ListTile(
                        //           leading: Container(
                        //               width: 50,
                        //               height: 50,
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(25),
                        //                 color: AppColors.colors[index % AppColors.colors.length],
                        //               ),
                        //               child:  Center(
                        //                   child: Text(controller.list[0].trueCaller![index].fullName.toString().substring(1,2),
                        //                       style: TextStyle(
                        //                           color: AppColors.colors2[index % AppColors.colors2.length], fontSize: 20)))),
                        //           title: Text(controller.list[0].trueCaller![index].fullName.toString()),
                        //           subtitle: Text(controller.list[0].trueCaller![index].mobile.toString()),
                        //         );
                        //       },
                        //     )
                        // ),
                      ],
                    ):
                    controller.listTrueResult.isNotEmpty?
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text('Global search', style: TextStyle( fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                            child: ListView.builder(
                              itemCount: searchNumberController.list[0].trueCaller!.length
                              //     <3?
                              // searchNumberController.list[0].myContact!.length : 3
                              ,
                              itemBuilder: (context, index) {
                                //print('list of myContact${searchNumberController.listMyContact.length}');
                                return ListTile(
                                  leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColors.colors[index % AppColors.colors.length],
                                      ),
                                      child:  Center(
                                          child: Text(controller.list[0].trueCaller![index].name.toString().substring(0,1),
                                              style: TextStyle(
                                                  color: AppColors.colors2[index % AppColors.colors2.length], fontSize: 20)))),
                                  title: Text(controller.list[0].trueCaller![index].name.toString()),
                                  subtitle: Text(controller.list[0].trueCaller![index].mobile.toString()),
                                );
                              },
                            )
                        ),

                      ],
                    ):
                    searchNumberController.list.isNotEmpty?
                    searchNumberController.list[0].hasAnotherContact.toString() == 'yes'?
                    ListTile(
                      leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.colors[1 % AppColors.colors.length],
                          ),
                          child:  Center(
                              child: Text('U',
                                  style: TextStyle(
                                      color: AppColors.colors2[1 % AppColors.colors2.length], fontSize: 20)))),
                      title: Text(controller.list[0].anotherContact.toString()),
                      subtitle: Text(number.text),
                    ):
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        Container(
                          child: Image.asset('assets/images/search.png',scale: 5),
                        ),
                      ],
                    ):
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        Container(
                          child: Image.asset('assets/images/search.png',scale: 5),
                        ),
                      ],
                    );
                  }
                }),
              ),
              // searchNumberController.viewOn.value?
              //     searchNumberController.isLoading.value?
              //     const Center(
              //       child: CircularProgressIndicator(),
              //     ):
              // Expanded(
              //     child: ListView.builder(
              //       itemCount: searchNumberController.listNumber!.length,
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           leading: Container(
              //               width: 50,
              //               height: 50,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(25),
              //                 color: AppColors.colors[index % AppColors.colors.length],
              //               ),
              //               child:  Center(
              //                   child: Text(searchNumberController.listName![index].toString().substring(0,1),
              //                       style: TextStyle(
              //                           color: AppColors.colors2[index % AppColors.colors2.length], fontSize: 20)))),
              //           title: Text(searchNumberController.listName![index].toString()),
              //           subtitle: Text(searchNumberController.listNumber![index].toString()),
              //         );
              //       },
              //     )):
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(height: 50,),
              //     Container(
              //       child: Image.asset('assets/images/search.png',scale: 5),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
