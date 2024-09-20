import 'dart:async';
import 'package:flutter/material.dart';

class Slide extends StatefulWidget {
  const Slide({Key? key}) : super(key: key);

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  int paginaAtual = 0;
  int quantidadeDePaginas = 4;
  PageController controller = PageController();
  List<double> progresso = [0.0, 0.0, 0.0, 0.0];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int page = controller.page!.round();
      if (paginaAtual != page) {
        setState(() {
          paginaAtual = page;
          resetar();
        });
      }
    });
    proximaPage();
    iniciarOProgesso();
  }

  void proximaPage() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (paginaAtual < quantidadeDePaginas - 1) {
        controller.nextPage(
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      } else {
        controller.animateToPage(0,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      }
    });
  }

  void iniciarOProgesso() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (progresso[paginaAtual] < 1) {
          progresso[paginaAtual] += 0.02;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void resetar() {
    for (int i = 0; i < quantidadeDePaginas; i++) {
      progresso[i] = 0.0;
    }
    iniciarOProgesso();
  }

  List<Widget> indicator() {
    List<Widget> list = [];
    for (int i = 0; i < quantidadeDePaginas; i++) {
      list.add(Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: paginaAtual == i ? Colors.white : Colors.grey,
        ),
      ));
    }
    return list;
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300, 
      
      child: ShaderMask(
        shaderCallback:(rect){
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent]
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        }, 
        blendMode: BlendMode.dstIn,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              controller: controller,
              children: [
                buildSlide('assets/filmeSlide1.png'),
                buildSlide('assets/filmeSlide2.png'),
                buildSlide('assets/filmeSlide3.png'),
                buildSlide('assets/filmeSlide4.png'),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  Widget buildSlide(String imagePath) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
