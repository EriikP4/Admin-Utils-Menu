Texto = "ADVERTENCIA" + Chr(13) + Chr(10) + Chr(13) + Chr(10)
Texto = Texto + "Cuando se finaliza una sesi�n remota, la invitaci�n correspondiente queda inservible y ser� eliminada." + Chr(13) + Chr(10) + Chr(13) + Chr(10)
Texto = Texto + "Cada sesi�n contiene un n�mero de identificador �nico" + Chr(13) + Chr(10)
Texto = Texto + "(incluido en la invitaci�n), significando as� que cada sesi�n utiliza una invitaci�n distinta."
Tempo = MsgBox(Texto, 48)