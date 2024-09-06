import 'dart:ui';

import 'package:corpoelec_cc_demo/botao_animado.dart';
import 'package:corpoelec_cc_demo/input_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animacaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animacaoBlur = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease,
      ),
    );

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.decelerate,
      ),
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'images/corpoelec.png',
                  height: 300,
                  // width: size,
                  // height: haveWidth != null && haveWidth! ? size : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 0),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _animacaoSize!,
                      builder: (context, widget) {
                        return Container(
                          width: _animacaoSize?.value,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 80,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              const InputCustomizado(
                                hint: 'Usuario',
                                obscure: false,
                                icon: Icon(Icons.person),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.5,
                                    ),
                                  ],
                                ),
                              ),
                              const InputCustomizado(
                                hint: 'Contraseña',
                                obscure: true,
                                icon: Icon(Icons.lock),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BotaoAnimado(controller: _controller!),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
