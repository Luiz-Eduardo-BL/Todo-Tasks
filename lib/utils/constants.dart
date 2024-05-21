import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todotasks/main.dart';
import 'package:todotasks/utils/app_str.dart';

const String lottieURL = 'assets/lottie/1.json';

dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'Você deve preencher todos os campos!!',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'Você deve editar as tarefas e tentar atualizá-las!',
    corner: 20.0,
    duration: 3000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.show(
    context,
    title: AppStr.oopsMsg,
    message:
        "Não há nenhuma tarefa para excluir!\n Tente adicionar algumas e depois tente excluí-las!",
    buttonText: "Ok",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

dynamic deleteAllTaskWarning(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message:
        "Você realmente deseja excluir todas as tarefas? Não será possível desfazer essa ação!",
    confirmButtonText: "Sim",
    cancelButtonText: "Não",
    onTapConfirm: () {
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
