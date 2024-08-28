import 'package:flutter/material.dart';
import 'package:starlitfilms/components/styles.dart';


Widget card(largura, altura, Color cor, String txt, String img){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
    child: Card(
      color: cor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(txt, style: txtNunitoBoldWhite(16)),
          Image.asset(img),
        ]
      )
    ),
    );
}
Widget cardBlack(largura, altura, Color cor, String txt, String img){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
    child: Card(
      color: cor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(txt, style: txtNunitoBold(16)),
          Image.asset(img),
        ]
      )
    ),
    );
}
Widget cardColumn(largura, altura, Color cor, String txt, String img){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
    child: Card(
      color: cor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(txt, style: txtNunitoBold(16)),
          Image.asset(img),
        ]
      )
    ),
    );
}
Widget cardCarrinho(largura, altura, Color cor, String txt ,String txt2, String img){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1)
    ),
    child: Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.transparent,)
      ),
      color: cor,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                child: Text(txt, style: txtNunitoBold(20)),
              ),
              
              Image.asset(img, width: 70, height: 70,),
            ]
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(txt2, style: txtNunito300(15)),
            
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: SizedBox(
              width: 400,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red),
                onPressed: (){}, child: const Text('Adicionar a sacola', style: TextStyle( color: Colors.white, fontSize: 20 ), ))),
          ) 
        ],
      )
    ),
    );
}

Widget cardHistorico(largura, altura,String img, Color cor, String txt ,String txt2, String txt3 ){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1)
    ),
    child: Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.transparent,)
      ),
      color: cor,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                child: Image.asset(img, width: 70, height: 70,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                child: Text(txt, style: txtNunitoBold(20)),
              ),
              
              
              
            ]
          ),
          const Divider(),

          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
            child: Text(txt2, style: txtNunito300(15)),
            
          ),
           Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
            child: Text(txt3, style: txtNunito300(15)),
            
          ),
          const Divider()
         
        ],
      )
    ),
    );
}
Widget cardHistorico1(largura, altura,String img, Color cor, String txt ,String txt2, textFormField ){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1)
    ),
    child: Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.transparent,)
      ),
      color: cor,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,80,20),
                child: Image.asset(img, width: 70, height: 70,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                child: Text(txt, style: txtNunitoBold(20)),
              ),
              
              
              
            ]
          ),
          const Divider(),

          Padding(
            
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text('Busque por Cidade'),
                hintText: textFormField
              ),
            ),
            
          ),
           
          
         
        ],
      )
    ),
    );
}


Widget cardHome(largura, altura, Color cor, String txt, String img, String txt2){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
    child: Card(
      color: cor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(img, width: 40, height: 40,),
          Text(txt, style: txtNunitoBold(16), textAlign: TextAlign.center,),
          Text(txt2, style: txtNunito300(12), textAlign: TextAlign.center),
        ]
      ),
    )
  );
}

Widget cardFi(largura, altura, Color cor, String txt, String img, String txt2){
  return Container(
    width: largura,
    height: altura,
    margin: const EdgeInsets.all(8),
      color: cor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(img, width: 100, height: 100,),
          Text(txt, style: txtNunitoBold(16)),
          Text(txt2, style: txtNunitoBold(12)),
        ]
      ),
    );
}