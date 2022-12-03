import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../controller/auth_controller.dart';
import '../widgets/text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final userNameController = TextEditingController();

  int bgMotionSensitivity = 6;
  int bgMotionSensitivityL2 = 8;
  int planetMotionSensitivity = 2;

  late final size = MediaQuery.of(context).size;

  void signIn(){
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        username: userNameController.text,
        context: context
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          StreamBuilder<AccelerometerEvent>(
            builder: (context, event){
              final AccelerometerEvent? acceleration = event.data;
              if(acceleration == null) {
                return Container();
              }
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                top: acceleration.y * bgMotionSensitivityL2,
                bottom: acceleration.y * -bgMotionSensitivityL2,
                right: acceleration.x * -bgMotionSensitivityL2,
                left: acceleration.x * bgMotionSensitivityL2,
                child: Align(
                  child: Image.asset(
                    "assets/images/stars_layer_2.png",
                    height: size.height,
                    fit: BoxFit.cover,
                    //fit: BoxFit.fitHeight,
                  ),
                ),
              );
            },
          ),

          StreamBuilder<AccelerometerEvent>(
            builder: (context, event){
              final AccelerometerEvent? acceleration = event.data;
              if(acceleration == null) {
                return Container();
              }
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                top: acceleration.y * bgMotionSensitivity,
                bottom: acceleration.y * -bgMotionSensitivity,
                right: acceleration.x * -bgMotionSensitivity,
                left: acceleration.x * bgMotionSensitivity,
                child: Align(
                  child: Image.asset(
                    "assets/images/stars_layer_1.png",
                    height: size.height,
                    fit: BoxFit.cover,
                    //fit: BoxFit.fitHeight,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Container(
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.1,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 40
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Already a member? Login",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 25
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    context.replace('/');
                                  },
                                  icon: const Icon(Icons.arrow_forward_rounded, color: Colors.teal,))
                            ],
                          ),
                          SizedBox(height: size.height * 0.05,),
                        ],
                      ),
                      SizedBox(height: size.height * 0.05,),
                      CustomTextField(controller: emailController, hintText: 'Email'),
                      const SizedBox(height: 20,),
                      CustomTextField(controller: nameController, hintText: 'Name'),
                      const SizedBox(height: 20,),
                      CustomTextField(controller: userNameController, hintText: 'Username'),
                      const SizedBox(height: 20,),
                      CustomTextField(controller: passwordController, hintText: 'Password'),
                      const SizedBox(height: 20,),
                      isLoading? const CircularProgressIndicator():
                      ElevatedButton(
                          onPressed: () => signIn(),
                          child: const Text("Enter World")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}