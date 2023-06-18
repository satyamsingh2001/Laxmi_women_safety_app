import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:laxmi/constants/CustomTextField.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/db/db_services.dart';
import 'package:laxmi/models/contants_model.dart';
import 'package:laxmi/utils/Utils.dart';
import 'package:permission_handler/permission_handler.dart';

class Contact_Page extends StatefulWidget {
  const Contact_Page({Key? key}) : super(key: key);

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}

class _Contact_PageState extends State<Contact_Page> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlattren = flattenPhoneNumber(searchTerm);
        String contactName = element.displayName!.toLowerCase();
        bool nameMatch = contactName.contains(searchTerm);
        if (nameMatch == true) {
          return true;
        }
        if (searchTermFlattren.isEmpty) {
          return false;
        }
        var phone = element.phones!.firstWhere((p) {
          String phnFLattered = flattenPhoneNumber(p.value!);
          return phnFLattered.contains(searchTermFlattren);
        });
        return phone.value != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  Future<void> askpermission() async {
    PermissionStatus permissionStatus = await getContactPermission();
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    } else {
      handInvaliedPermissions(permissionStatus);
    }
  }

  handInvaliedPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      DialogBox(context, "Access to the contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      DialogBox(context, "May contact does exist in this device");
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async {
    List<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchIng = searchController.text.isNotEmpty;
    bool listItemExit = (contactsFiltered.length > 0 || contacts.length > 0);
    return Scaffold(
        body: contacts.length == 0
            ? progressIndicator(context)
            : SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: searchController,
                        isPassword: false,
                        autofoc: false,
                        labeltxt: "Search Contacts",
                        prefix: Icon(Icons.search),
                      ),
                    ),
                    listItemExit == true
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: isSearchIng == true
                                    ? contactsFiltered.length
                                    : contacts.length,
                                shrinkWrap: true,
                                // primary: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, int index) {
                                  Contact contact = isSearchIng == true
                                      ? contactsFiltered[index]
                                      : contacts[index];
                                  return ListTile(
                                      onTap: () {
                                        if (contact.phones!.length > 0) {
                                          final String phoneNum =
                                          contact.phones!.elementAt(0).value!;
                                          final String name = contact.displayName!;
                                          _addContact(Contact_Model(phoneNum, name));
                                        } else {
                                          Utils.showToastMsg("Oops! phone number of this contact does exist");
                                        }
                                      },
                                      title: Text(contact.displayName!),
                                      subtitle: Text(
                                          contact.phones!.elementAt(0).value!),
                                      leading: contact.avatar != null &&
                                              contact.avatar!.length > 0
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  MemoryImage(contact.avatar!),
                                              backgroundColor:
                                                  ConstantColor.button,
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  ConstantColor.button,
                                              child: Text(contact.initials()),
                                            ));
                                }),
                          )
                        : Text("searching"),
                  ],
                ),
              ));
  }

  void _addContact(Contact_Model newContact) async{
    int result = await _databaseHelper.inserContact_Model(newContact);
    if (result != 0) {
      Utils.showToastMsg( "Contact added successfully");
    } else {
      Utils.showToastMsg( "Failed to add contacts");
    }
    Navigator.of(context).pop(true);
  }

}

