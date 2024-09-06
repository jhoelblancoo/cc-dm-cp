import 'package:corpoelec_cc_demo/dashboard_screen.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF233970); // 0xFFA42037 - 0xFF2C399F

class BotaoAnimado extends StatelessWidget {
  AnimationController controller;
  Animation<double> largura;
  Animation<double> altura;
  Animation<double> radius;
  Animation<double> opacidade;

  BotaoAnimado({super.key, required this.controller})
      : largura = Tween<double>(
          begin: 0,
          end: 500,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.5),
          ),
        ),
        altura = Tween<double>(
          begin: 0,
          end: 50,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.7),
          ),
        ),
        radius = Tween<double>(
          begin: 0,
          end: 20,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0),
          ),
        ),
        opacidade = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.8),
          ),
        );

  Widget _buildAnimation(BuildContext context, Widget? widget) {
    return InkWell(
      onTap: () async {
        print('aqui');
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
        );
      },
      child: Container(
        width: largura.value,
        height: altura.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.value),
          gradient: const LinearGradient(
            colors: [
              primaryColor,
              primaryColor,
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: opacidade,
            child: const Text(
              "Siguiente",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
