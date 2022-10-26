import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_app/src/config/app_routes.dart';
import 'package:medical_app/src/cores/components/components.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/data_layer/data_sourse/local/sharedprefrencese_helper.dart';
import 'package:medical_app/dependency_injection.dart' as di;

import '../../data_layer/models/edit_profile_model.dart';
import '../../domin_layer/editprofile_cubit/editprofile_cubit.dart';
import '../../domin_layer/editprofile_cubit/editprofile_state.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  var shared = di.sl<SharedPrefrencesHelper>();
  @override
  Widget build(BuildContext context) {
    nameController.text = shared.getData(key: 'name');
    emailController.text = shared.getData(key: 'email');
    return Builder(builder: (context) {
      return BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileError) {
            context.loaderOverlay.hide();
            defaultSnakbar(content: state.message, context: context);
          }

          if (state is EditProfileSuccess) {
            if (state.EditProfilemodel.status == true) {
              shared.setData(
                  key: 'name', value: state.EditProfilemodel.usermodel.name);
              shared.setData(key: 'password', value: passwordConfirmController.text.isNotEmpty?passwordConfirmController.text: shared.getData(key: 'password'));
              shared.setData(
                  key: 'email',
                  value: state.EditProfilemodel.usermodel.email);
              context.loaderOverlay.hide();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.homeScreen, (route) => false);
               defaultSnakbar(color: Colors.green, content: 'تم التعديل بنجاح', context: context);   
            } else {
              context.loaderOverlay.hide();
              defaultSnakbar(
                  content: 'هناك خطا حاول مرة اخرى !', context: context);
            }
          }
        },
        builder: (context, state) {
          var cubit = di.sl<EditProfileCubit>();
          return Directionality(
              textDirection: TextDirection.rtl,
              child: LoaderOverlay(
                useDefaultLoading: true,
                overlayColor: Colors.black,
                overlayOpacity: 0.3,
                child: Scaffold(
                    backgroundColor: Colors.white,
                    resizeToAvoidBottomInset: false,
                    body: SafeArea(
                        child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(
                            AppMediaQuery.height(context: context) * 0.05),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.jpg',
                                  width: MediaQuery.of(context).size.width *
                                      0.20,
                                ),
                                Text(
                                  'منصة شفاء',
                                  style: TextStyle(
                                      fontSize: AppMediaQuery.width(
                                              context: context) *
                                          0.03,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height:
                                      AppMediaQuery.height(context: context) *
                                          0.03,
                                ),
                                Text(
                                  'تعديل البيانات',
                                  style: TextStyle(
                                      fontSize: AppMediaQuery.width(
                                              context: context) *
                                          0.04,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height:
                                      AppMediaQuery.height(context: context) *
                                          0.03,
                                ),
                                defaultTextFormFaield(
                                    controller: nameController,
                                    type: TextInputType.name,
                                    hint: 'الإسم',
                                    action: TextInputAction.next,
                                    valid: (val) {
                                      if (val.isEmpty) {
                                        return 'أدخل الإسم !';
                                      }
                                      return null;
                                    },
                                    context: context),
                                SizedBox(
                                  height:
                                      AppMediaQuery.height(context: context) *
                                          0.02,
                                ),
                                defaultTextFormFaield(
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    hint: 'البريد الإلكتروني',
                                    action: TextInputAction.next,
                                    valid: (val) {
                                      if (val.isEmpty) {
                                        return 'أدخل البريد الإلكتروني !';
                                      }
                                      return null;
                                    },
                                    context: context),
                                SizedBox(
                                  height:
                                      AppMediaQuery.height(context: context) *
                                          0.02,
                                ),
                                defaultTextFormFaield(
                                    controller: passwordController,
                                    type: TextInputType.text,
                                    hint: '  كلمة المرور القديمة',
                                    action: TextInputAction.next,
                                    valid: (val) {
                                      if (val.isEmpty &&
                                          passwordConfirmController
                                              .text.isNotEmpty) {
                                        return 'أدخل  كلمة المرور القديمة !';
                                      }
                                      return null;
                                    },
                                    ispassword: cubit.ispassword,
                                    changepassword: () =>
                                        cubit.obscurePasswordFun(),
                                    suffixicon: cubit.ispassword
                                        ? const Icon(
                                            Icons.visibility_off_rounded)
                                        : const Icon(
                                            Icons.visibility_rounded),
                                    context: context),
                                SizedBox(
                                  height:
                                      AppMediaQuery.height(context: context) *
                                          0.02,
                                ),
                                defaultTextFormFaield(
                                    controller: passwordConfirmController,
                                    type: TextInputType.text,
                                    hint: 'كلمة المرور الجديدة ',
                                    action: TextInputAction.next,
                                    valid: (val) {
                                      if (val.isEmpty &&
                                          passwordController
                                              .text.isNotEmpty) {
                                        return '  أدخل  كلمة المرور الجديدة !';
                                      }
                                      return null;
                                    },
                                    ispassword: cubit.ispassword,
                                    changepassword: () =>
                                        cubit.obscurePasswordFun(),
                                    suffixicon: cubit.ispassword
                                        ? const Icon(
                                            Icons.visibility_off_rounded)
                                        : const Icon(
                                            Icons.visibility_rounded),
                                    context: context),
                                SizedBox(
                                  height:
                                      AppMediaQuery.height(context: context) *
                                          0.02,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: defaultButton(
                                      context: context,
                                      title: 'تعديل',
                                      colorTitle: Colors.white,
                                      colorBtn: Colors.Mycolor,
                                      onPressed: () {
                                        if (formkey.currentState!
                                            .validate()) {
                                          if (passwordController
                                                  .text.isNotEmpty &&
                                              passwordController.text !=
                                                  shared.getData(
                                                      key: 'password')) {
                                            defaultSnakbar(
                                                content:
                                                    'كلمة المرور القديمة غير صحيحة',
                                                context: context);
                                          } else {
                                            context.loaderOverlay.show();
                                            EditProfileModel model = EditProfileModel(
                                                usermodel: UserModel(
                                                    name: nameController.text,
                                                    email:
                                                        emailController.text,
                                                    password: passwordConfirmController
                                                            .text.isNotEmpty
                                                        ? passwordConfirmController
                                                            .text
                                                        : shared.getData(
                                                            key:
                                                                'password')));
                                            cubit.editProfileCubitFun(
                                                body:
                                                    model.usermodel.toMap());
                                          }
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))),
              ));
        },
      );
    });
  }
}
