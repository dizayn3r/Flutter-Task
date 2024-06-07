import 'package:flutter/material.dart';
import 'package:flutter_interview_task/core/extensions/space_extension.dart';
import 'package:flutter_interview_task/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class UserForm extends StatefulWidget {
  final String title;
  final User? user;

  const UserForm({super.key, required this.title, this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _userFormKey = GlobalKey<FormState>();

  /// User Basic Controller
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();

  /// Address Controller
  final streetController = TextEditingController();
  final suiteController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();

  /// Company Controller
  final companyNameController = TextEditingController();
  final catchPhraseController = TextEditingController();
  final bsController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.user?.name ?? "";
    usernameController.text = widget.user?.username ?? "";
    emailController.text = widget.user?.email ?? "";
    phoneController.text = widget.user?.phone ?? "";
    websiteController.text = widget.user?.email ?? "";
    streetController.text = widget.user?.address?.street ?? "";
    suiteController.text = widget.user?.address?.suite ?? "";
    cityController.text = widget.user?.address?.city ?? "";
    zipCodeController.text = widget.user?.address?.zipcode ?? "";
    latController.text = widget.user?.address?.geo?.lat ?? "";
    longController.text = widget.user?.address?.geo?.lng ?? "";
    companyNameController.text = widget.user?.company?.name ?? "";
    catchPhraseController.text = widget.user?.company?.catchPhrase ?? "";
    bsController.text = widget.user?.company?.bs ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Form(
      key: _userFormKey,
      child: ListView(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name Input Field
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Name";
                    }
                    return null;
                  },
                  onSaved: (value) => nameController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Username Input Field
                TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(labelText: "Username"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter username";
                    }
                    return null;
                  },
                  onSaved: (value) => usernameController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Email Input Field
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter email";
                    }
                    return null;
                  },
                  onSaved: (value) => emailController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Phone Input Field
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "Phone"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter phone";
                    }
                    return null;
                  },
                  onSaved: (value) => phoneController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Website Input Field
                TextFormField(
                  controller: websiteController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Website"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter website";
                    }
                    return null;
                  },
                  onSaved: (value) => websiteController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Address Box
                const Text(
                  "Address",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ).bottomSpacing(8.0),

                /// Street Input Field
                TextFormField(
                  controller: streetController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(labelText: "Street"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter street name";
                    }
                    return null;
                  },
                  onSaved: (value) => streetController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Suite Input Field
                TextFormField(
                  controller: suiteController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Suite"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter suite";
                    }
                    return null;
                  },
                  onSaved: (value) => suiteController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// City Input Field
                TextFormField(
                  controller: cityController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "City"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your city";
                    }
                    return null;
                  },
                  onSaved: (value) => cityController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Zip Code Input Field
                TextFormField(
                  controller: zipCodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Zip code"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your zipcode";
                    }
                    return null;
                  },
                  onSaved: (value) => zipCodeController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Latitude Input Field
                TextFormField(
                  controller: latController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Latitude"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your latitude";
                    }
                    return null;
                  },
                  onSaved: (value) => latController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Longitude Input Field
                TextFormField(
                  controller: longController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Longitude"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your longitude";
                    }
                    return null;
                  },
                  onSaved: (value) => longController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Company Box
                const Text(
                  "Company",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ).bottomSpacing(8.0),

                /// Company Name Input Field
                TextFormField(
                  controller: companyNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Company Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your company name";
                    }
                    return null;
                  },
                  onSaved: (value) => companyNameController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Company Catch Phrase Input Field
                TextFormField(
                  controller: catchPhraseController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Catch Phrase"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your company catch phrase";
                    }
                    return null;
                  },
                  onSaved: (value) => catchPhraseController.text = value!.trim(),
                ).bottomSpacing(16.0),

                /// Company BS Input Field
                TextFormField(
                  controller: bsController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "BS"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your company bs";
                    }
                    return null;
                  },
                  onSaved: (value) => bsController.text = value!.trim(),
                ).bottomSpacing(16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Colors.white,
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: const Text("Reset"),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool validate = _userFormKey.currentState!.validate();
                          if (validate) {
                            Geo geo = Geo(
                              lat: latController.text,
                              lng: longController.text,
                            );
                            Address address = Address(
                              street: streetController.text,
                              suite: suiteController.text,
                              city: cityController.text,
                              zipcode: zipCodeController.text,
                              geo: geo,
                            );
                            Company company = Company(
                              name: companyNameController.text,
                              catchPhrase: catchPhraseController.text,
                              bs: bsController.text,
                            );
                            User user = User(
                              name: nameController.text,
                              username: usernameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              website: websiteController.text,
                              address: address,
                              company: company,
                            );
                            if (widget.user == null) {
                              userProvider.createUser(user: user).then((value) {
                                if (value) {
                                  SnackBar snackBar = const SnackBar(
                                    content: Text("User created successfully!"),
                                    backgroundColor: Colors.green,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                Navigator.of(context).pop();
                              });
                            } else {
                              userProvider.updateUser(user: user).then((value) {
                                if (value) {
                                  SnackBar snackBar = const SnackBar(
                                    content: Text("User created successfully!"),
                                    backgroundColor: Colors.green,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                Navigator.of(context).pop();
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
