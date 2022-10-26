import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_app/src/config/app_routes.dart';
import 'package:medical_app/src/cores/components/components.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/data_layer/data_sourse/local/sharedprefrencese_helper.dart';
import 'package:medical_app/src/data_layer/models/register_model.dart';
import 'package:medical_app/dependency_injection.dart' as di;

import '../../domin_layer/registeration_cubit/register_cubit.dart';
import '../../domin_layer/registeration_cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            context.loaderOverlay.hide();
            defaultSnakbar(content: state.message, context: context);
          } else if (state is RegisterSuccess) {
            if (state.registermodel.status == true) {
              di.sl<SharedPrefrencesHelper>().setData(
                  key: 'name', value: state.registermodel.usermodel.name);
              di
                  .sl<SharedPrefrencesHelper>()
                  .setData(key: 'password', value: passwordController.text);
              di.sl<SharedPrefrencesHelper>().setData(
                  key: 'email', value: state.registermodel.usermodel.email);
              di.sl<SharedPrefrencesHelper>().setData(
                  key: 'token', value: 'Bearer ${state.registermodel.token}');
              context.loaderOverlay.hide();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.homeScreen, (route) => false);
            } else {
              context.loaderOverlay.hide();
              defaultSnakbar(
                  content: 'هناك خطا حاول مرة اخرى !', context: context);
            }
          }
        },
        builder: (context, state) {
          var cubit = di.sl<RegisterCubit>();
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
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
                                  'تسجيل حساب',
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
                                    hint: 'كلمة المرور',
                                    action: TextInputAction.next,
                                    valid: (val) {
                                      if (val.isEmpty) {
                                        return 'أدخل كلمة المرور !';
                                      }
                                      return null;
                                    },
                                    ispassword: cubit.ispassword,
                                    changepassword: () =>
                                        cubit.obscurePasswordFun(),
                                    suffixicon: cubit.ispassword
                                        ? const Icon(Icons.visibility_off_rounded)
                                        : const Icon(Icons.visibility_rounded),
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
                                      title: 'تسجيل',
                                      colorTitle: Colors.white,
                                      colorBtn: Colors.Mycolor,
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          context.loaderOverlay.show();
                                          RegisterModel model = RegisterModel(
                                              usermodel: UserModel(
                                                  name: nameController.text,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text));
                                          cubit.registerCubitFun(
                                              body: model.usermodel.toMap());
                                        }
                                      }),
                                ),
                                SizedBox(
                                  height:
                                      AppMediaQuery.height(context: context) *
                                          0.02,
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          AppRoutes.loginScreen,
                                          (route) => false),
                                  child: Text(
                                    'لديك حساب ؟ سجل الدخول .',
                                    style: TextStyle(
                                        fontSize: AppMediaQuery.width(
                                                context: context) *
                                            0.04,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))),
              ));
        },
      ),
    );
  }
}
