import 'package:mobx/mobx.dart';

part 'controller.g.dart';

class ControllerCount = ControllerCountBase with _$ControllerCount;

abstract class ControllerCountBase with Store
{
  
  @observable
  int contador = 0;

  @action
  void incremetarContador(){
    contador++;
  }

  @action
  void decrementarContador(){
    if (contador > 0) {
        contador--;
    }
  }

  @action
  void reiniciarContador(){
    contador = 0;
  }
}


