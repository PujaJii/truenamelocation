import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/contact_upload_controller.dart';
import '../pages/search_page.dart';
import '../pages/user_profile.dart';

import '../styles/app_colors.dart';


class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  List<String> name = [];
  List<String> number = [];
  ContactUploadController contactUploadController = Get.put(ContactUploadController());
  List<String> specialChars = [
    '\'',
    ',',
    '\\',
    '|',
    '"',
    '/',
  ];


  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContacts();

   // getContactPermission();
  }


  Future<void> fetchContacts() async {
    contacts = await ContactsService.getContacts();

    setState(() {
      isLoading = false;
    });
    for(var el in contacts){


      ///name filters............
      if(el.displayName == null || el.displayName == ''){
        // name.add('Unknown');
      }
      else if(el.displayName!.contains(',')){
        String originalString = el.displayName!;
        String replacedString = originalString.replaceAll(',', '');
        print(replacedString);

        name.add(replacedString);
        print('comanames${replacedString}');
      }
      else if(el.displayName!.contains('\'')){
        String originalString = el.displayName!;
        String replacedString = originalString.replaceAll('\'', '');
        // print(replacedString);
        name.add(replacedString);
        print('comanames${replacedString}');
      }

      else if(el.phones ==null || el.phones!.isEmpty){

      }
      else{
        name.add(el.displayName.toString());
      }


      ///number filters............
      if(el.phones ==null || el.phones!.isEmpty){
       // number.add('000000');
      }else{
        number.add(el.phones!.first.value.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(name);
    print(number);
    contactUploadController.uploadContact(name, number);
    return SafeArea(
      child: Scaffold(
        body: isLoading ?
         const Center(
           child: CircularProgressIndicator(color: AppColors.themeColor,),) :
        Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: InkWell(
                onTap: () {
                  Get.to(() => const SearchPage());
                },
                child: Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    //side:  BorderSide(color: AppColors.pattern1, width: 1),
                  ),
                  // borderRadius: BorderRadiusGeometry,
                  child: Container(
                    height: 45,
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: Row(
                      children:  [
                        //const SizedBox(width: 15,),
                        Container(
                          height: 33,
                          width: 33,
                          margin: const EdgeInsets.only(left: 15),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/my_profile.jpg'))),
                        ),
                        const Text('    Search numbers, names & more'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('Total Contacts (${contacts.length.toString()})'),
            Expanded(

              child: ListView.builder(
                   itemCount: contacts.length,
                   itemBuilder: (context, index) {
                   return contacts[index].phones ==null || contacts[index].phones!.isEmpty? Container():
                     InkWell(
                     onTap: () {
                       Get.to(()=> UserProfile(
                           contacts[index].givenName.toString(),
                           contacts[index].phones!.first.value.toString(),
                           AppColors.colors[index % AppColors.colors.length],AppColors.colors2[index % AppColors.colors.length]));
                     },
                     child: ListTile(
                      leading: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.themeColor,),
                              borderRadius: BorderRadius.circular(25),color: AppColors.colors[index % AppColors.colors.length],
                            ),
                            child: contacts[index].givenName == null || contacts[index].givenName == ''?
                            Center(child:  Text('U',style: TextStyle(color: AppColors.colors2[index % AppColors.colors.length],fontSize: 20))):
                            Center(child: Text(((contacts[index].givenName!).substring(0,1)),
                                style: TextStyle(color: AppColors.colors2[index % AppColors.colors.length],fontSize: 20))),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              height: 15,width: 15,
                              decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  border: Border.all(width: 1.5,color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Text('i',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontFamily: 'JacquesFrancois-Regular'),),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              // height: 17,width: 17,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: AppColors.themeColor2,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,
                                      offset: Offset(
                                        0,
                                        3,
                                      ),
                                    )]
                              ),
                              child: const Center(
                                child: Text('17m',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      title:
                      contacts[index].displayName == null || contacts[index].displayName == ''?
                      const Text('Unknown'):
                      Text(contacts[index].displayName!,style: const TextStyle(fontSize: 14)),
                      subtitle:contacts[index].phones ==null || contacts[index].phones!.isEmpty?
                      const Text(''):
                      Text(contacts[index].phones!.first.value.toString()),
                  ),
                   );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}