Configuración de parámetros de la configuración explicada detalladamente:
·limiteRAM:
	Es el umbral de RAM en MB a partir del cual el indicador se pone rojo. Su valor actual y predeterminado es 7 MB.
	Por debajo de ese umbral el indicador permanece verde.
	
·intervalo:
	Es el intervalo de actualizacion de la comprobación de RAM de Veyon en milisegundos. Su valor actual y predeterminado es 1 ms.
	
·modoVisual:
	Determina si se muestra el símbolo del estado, la cantidad de RAM, ambos o ninguno. Las opciones son "simbolo", "numerico", "ambos" (símbolo y cifra a la vez) u "oculto" (no muestra nada en pantalla, pero las macros y las notificaciones siguen funcionando).
	
·enviarCtrl:
	Sirve para enviar Ctrl al entrar en rojo, sus opciones son "true" o "false".

·notificacionesWindows:
	Muestra una notificacion de Windows al entrar en rojo. Sus opciones son "true" o "false".
	
·macroRojo:
	Combinacion de teclas que se envia una sola vez al entrar en rojo, por ejemplo "alt+tab" o "ctrl+alt+m",
	sin las comillas. Dejala vacia para desactivarla. Se admiten letras, numeros, F1 a F12 y los modificadores
	ctrl, alt, shift y win, ademas de tab, enter, esc, espacio, supr, retroceso, inicio, fin, repag, avpag y las flechas.
	Se pulsan las teclas en el orden indicado y se sueltan en orden inverso.
	
·macrosActivas:
	Activa o desactiva la macro roja sin borrar la combinacion configurada. Sus opciones son "true" o "false".
	
Recomendaciones:
	·No modificar ningún parámetro si no sabes que haces

	·Reiniciar el ordenador cada 2-3 horas, ya que el proceso del veyon puede dar falsos positivos porque acumula mucha memoria RAM.
	
	·Para que PowerShell no aparezca en la barra de tareas, ejecuta iniciar.vbs con doble clic en lugar
	 de abrir script.ps1 directamente. Arranca el script sin consola ni ventana desde el primer instante.
	 Para cerrarlo, pulsa la tecla Fin en cualquier ventana (funciona aunque el indicador no tenga el foco).
	 Si no responde, usa el Administrador de tareas y finaliza el proceso "powershell".
	
	·Para validar script.conf sin iniciar el monitor, ejecuta en PowerShell:
	 .\bin\script.ps1 -ValidarConfiguracion
	El validador esta incluido en el propio script, muestra todos los errores y no modifica la configuracion.
	
	·Activar Mostrar la ubicación del puntero al presionar CTRL en WIN+R, escribes main.cpl en el recuadro de ejecutar y esta esa opción en 
	 opciones del puntero
	
	·Utiliza el script solo en equipos y contextos en los que tengas autorización. Las opciones de Ctrl y las macros pueden interactuar con la ventana activa.
	
	·Puede dar falsos positivos o falsos negativos; no es 100% fiable. El 99.67% obtenido en pruebas de los autores no garantiza el mismo resultado en otros equipos o situaciones.