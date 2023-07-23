import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_marko/Screens/register/cubit/cubit.dart';
import 'package:super_marko/Screens/register/cubit/state.dart';
import 'package:super_marko/layout/home_screen.dart';
import 'package:super_marko/network/cache_helper.dart';
import 'package:super_marko/shared/components/components.dart';
import 'package:super_marko/shared/components/constants.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/components/text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final File? profileImage;
  final pickerController = ImagePicker();

  RegisterScreen({super.key, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status!) {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.success,
              );
              if (kDebugMode) {
                print(state.loginModel.message);
              }
              if (kDebugMode) {
                print(state.loginModel.data!.token);
              }

              CacheHelper.saveData(
                      key: "token", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, const HomeScreen());
              });
            } else {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.error,
              );
              if (kDebugMode) {
                print(state.loginModel.message);
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      DefaultTextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        prefix: Icons.person,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        label: 'Name',
                        hint: 'Enter your name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefix: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        label: 'Email',
                        hint: 'Enter your email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        prefix: Icons.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone';
                          }
                          return null;
                        },
                        label: 'Phone',
                        hint: 'Enter your phone',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Icons.key,
                        suffix: RegisterCubit.get(context).suffix,
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePassword();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        label: 'Password',
                        hint: 'Enter your password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => Center(
                          child: defaultMaterialButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            radius: 20,
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: InkWell(
                                child: SvgPicture.asset(
                                  'assets/icon/google.svg',
                                  fit: BoxFit.none,
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: InkWell(
                                child: SvgPicture.asset(
                                  'assets/icon/facebook.svg',
                                  fit: BoxFit.none,
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                              ),
                              child: InkWell(
                                child: SvgPicture.asset(
                                  'assets/icon/twitter.svg',
                                  fit: BoxFit.none,
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
