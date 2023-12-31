import 'package:flutter/material.dart';

void showLoader(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.lightGreen),
                SizedBox(height: 20),
                Text('Carregando...',
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        );
      });
}

void showConfirmLogout(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.lightGreen),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tem certeza que deseja fazer logout?'),
                SizedBox(height: 20),
                Row(
                  children: [
                    InkWell(child: Text('Cancelar')),
                    Spacer(),
                    InkWell(child: Text('Cancelar')),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
