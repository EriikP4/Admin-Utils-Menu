Texto = "ADVERTENCIA" + Chr(13) + Chr(10) + Chr(13) + Chr(10)
Texto = Texto + "Cuando se finaliza una sesión remota, la invitación correspondiente queda inservible y será eliminada." + Chr(13) + Chr(10) + Chr(13) + Chr(10)
Texto = Texto + "Cada sesión contiene un número de identificador único" + Chr(13) + Chr(10)
Texto = Texto + "(incluido en la invitación), significando así que cada sesión utiliza una invitación distinta."
Tempo = MsgBox(Texto, 48)