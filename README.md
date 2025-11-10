Claro, aquí tienes la traducción al español:

---

VULFT - Script de bots de control total (Full Takeover). Requiere instalación manual en la carpeta vscripts/bots (todos los bots lanzados recientemente tienen este problema). Comportamiento de combate altamente dinámico. Roles de DotaBuff y builds de objetos actualizados el: 19/09/23. VUL-FT no está afiliado a DotaBuff.<br/>
<br/>
[Traducciones de esta página en otros idiomas](https://steamcommunity.com/groups/VULFT/announcements/detail/6966546241858334331)<br/>
<br/>

## == Instalación manual ==
Actualmente, VUL-FT no funcionará por suscripción. Revertirá a los bots predeterminados; parece que otros bots recientes tienen el mismo problema. Todavía estoy investigando qué está fallando allí. Por ahora, es necesario instalar los bots manualmente.<br/>
<br/>
Opcional: Antes de configurar VUL-FT como el script de desarrollo local, también puede ser una buena idea hacer una copia de seguridad de tu antigua carpeta 'vscript/bots' si tienes otro bot almacenado allí:<br/>
La carpeta local del bot de desarrollo se encuentra en<br/>
> [unidad]:/%Program Files%/Steam/steamapps/common/dota 2 beta/game/dota/scripts/vscripts/bots<br/>

0) renombrar la carpeta bots a bots.old.<br/>
1) crear una nueva carpeta llamada bots<br/>
2) copiar los archivos de VUL-FT desde GitHub o la carpeta del taller (workshop) a la nueva carpeta bots.<br/>
<br/>

### -- Mediante archivos locales del taller: (los archivos del taller verificados por Valve)
Después de suscribirte recientemente, encuentra la carpeta más reciente en<br/>
> [unidad]:/%Program Files%/Steam/steamapps/workshop/content/570/2872725543<br/>

y copia el contenido de esa carpeta a la carpeta bots en<br/>
> [unidad]:/%Program Files%/Steam/steamapps/common/dota 2 beta/game/dota/scripts/vscripts/bots/<br/>
<br/>

### -- Mediante Github: (actualizado por el creador)
Si sabes cómo usar git, puedes descargar manualmente los bots desde el [Github oficial de VUL-FT](https://github.com/Yewchi/vulft) y colocarlos en
> [unidad]:/%Program Files%/Steam/steamapps/common/dota 2 beta/game/dota/scripts/vscripts/bots/<br/>
<br/>

### -- Ejecución:
Después de completar uno de los pasos anteriores, puedes ejecutar los bots navegando en el juego a<br/>
Lobbies Personalizadas -> Crear -> Editar:<br/>
En CONFIGURACIÓN DE BOTS, cambia los bots del equipo a Script de Desarrollo Local (si aún quieres luchar contra los bots de Valve, ten en cuenta que también hay una opción para "Bots Predeterminados" aquí)<br/>
Cambia UBICACIÓN DEL SERVIDOR a HOST LOCAL (tu computadora).<br/>
La dificultad aún no tiene efecto.<br/>
Presiona ACEPTAR.<br/>
Únete a la ranura superior de cualquier equipo.<br/>
Presiona INICIAR JUEGO.<br/>
<br/>
Alternativamente, puedes usar la opción "Jugar VS Bots", pero no todos los héroes están implementados. Lamento todo esto, pero es solo el efecto de tener que ejecutar los bots como desarrollo, en lugar de a través del taller.<br/>
<br/>

## == Características ==

![GIF animado de VUL-FT en una pelea de equipo](https://steamuserimages-a.akamaihd.net/ugc/2028349340710795317/22D68EA70AEF6E343BBE3EBD5F1A3EF1C52F5A04/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false)

Toma de decisiones de combate dinámica.<br/>
Más parecido a un jugador real.<br/>

![GIF animado del bot Muerta huyendo de enemigos que usan orb walking](https://steamuserimages-a.akamaihd.net/ugc/2009206964554280836/186F1E4C8B555F0D06352C96399941EBBD9A29E5/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false)

Orb Walking (ataque y movimiento).<br/>
Gestión avanzada de objetos.<br/>
Ubicaciones de wards generadas y filtradas automáticamente para errores, si el mapa cambia alguna vez.<br/>
Analizador de DotaBuff para builds de habilidades promediadas de 5 partidas, roles y una build de objetos de jugadores Divino - Inmortales de esa semana.<br/>
Jungleo básico en tiempos muertos.<br/>
Pueden hacer jungleo y auto-negarse (self-deny) en el juego temprano si son atrapados por el enemigo.<br/>
Retirada dinámica hacia torres aliadas (a menos que la torre sea sobrepasada), o hacia aliados en la dirección de la fuente aliada.<br/>
Asignación de tareas de runas de bounty basada en proximidad, seguridad, niebla de guerra, índice de codicia.<br/>
Asignación de defensa de torres basada en la amenaza requerida.<br/>
Elige tu posición cuando quieras escribiendo en el chat "!pos [1-5]".<br/>
Menor uso de CPU que otros bots populares.<br/>
¡Errores (Bugs)!<br/>
<br/>
Además. Prometo que el código de este proyecto es 100% funcional sin conexión y seguirá siéndolo. Sin funciones de API de red, nunca.<br/>
<br/>

## == Reporte de errores ==
[Volcado de errores de Lua (enlace a discusión de Steam)](https://steamcommunity.com/workshop/filedetails/discussion/2872725543/3648503910213521285/) -- Usa esto si solo quieres volcar rápidamente alguna salida de la consola.

[Código fuente de VUL-FT](https://github.com/Yewchi/vulft) -- Github público

## == Aún no implementado ==
Comportamiento de combate macro, elección de iniciador, estrategias más grandes como cortar pérdidas, cambiar torres. Evaluarán las jugadas agresivas actuales y verán si creen que vale la pena para ellos mismos, si un enemigo está ocupado atacando a alguien más. La intención de pelea del enemigo es rastreada y pierde magnitud según la dirección a la que se enfrenta, esto permite que los aliados reconozcan intercambios sin ser atacados.<br/>
Comunicación por ping de jugador a bot.<br/>
Evaluaciones de visión enemiga.<br/>
Dewarding (eliminar wards).<br/>
Sentry y dust para sigilo enemigo.<br/>
Las ilusiones son controladas por el comportamiento predeterminado. (Pero el doble de Arc Warden es de control total).<br/>
Amenaza de fuente enemiga.<br/>
Evitar zonas.<br/>
Tipos de respuesta para lanzamientos de habilidades. (Rupture: Evitar movimiento innecesario)<br/>
Unidades estructurales de salud de unidad enemiga. (tumba de Undying, supernova de Phoenix)<br/>
Atacar y evitar unidades de súbditos-héroe. (lobos de Lycan, arañas de Broodmother)<br/>
Roshan.<br/>
Negar torres.<br/>
<br/>

## == Problemas conocidos ==
La selección de héroes puede favorecer en exceso los roles core.<br/>
Algunas tareas no están bien informadas por el código de análisis de amenazas, no todas las tareas utilizan funciones de movimiento inteligente para ajustar vectores alrededor de áreas peligrosas.<br/>
La basura no se vende correctamente (el analizador de meta de DotaBuff no está completo, y puede haber compras de basura adicionales analizadas incorrectamente en la build; las builds de objetos se calculan para sus combinaciones, sin embargo, la basura se evalúa incorrectamente y puede venderse el objeto equivocado cuando se tiene el inventario lleno de 9 slots).<br/>
Los bots no abandonan las líneas que son peligrosas si las están farmeando. Solo se retiran. Los datos no probados están ahí para cambiar de línea, pero la rotación a mitad de juego no está codificada, solo ocurre naturalmente mientras se mueven / consiguen runas / defienden torres / a veces haciendo jungleo. La puntuación de la oleada de súbditos los atrae con demasiada fuerza.<br/>
Excesivamente agresivos, especialmente en el juego temprano.<br/>
Los bots podrían no comprometerse con un push a la base enemiga (highground), debido a ciertas variables en el estado de la oleada de súbditos, podrían alejarse fuera del rango de push instead.<br/>
<br/>
Muchas otras cosas.<br/>
<br/>
Runas para bots de control total:<br/>
### -- las runas de agua inferiores (bottom water runes) no se pueden recoger.
### -- las runas de bounty del río (river bounty runes) no se pueden recoger.
### -- cualquier runa que esté apilada con otra runa de bounty no se puede recoger.
Estos tres problemas de runas son técnicamente ciertos, pero hay una solución provisional. Durante la etapa temprana del juego, los bots se ejecutan como un bot de control parcial, todos los modos están configurados para no hacer nada, el estado de uso de habilidades y objetos (ability_item_usage) se establece en 100% de deseo, y los bots usan eso como un gancho (hook) al código de control total. Cuando se paran junto a una runa, el modo runa se activa por una fracción de segundo, con la esperanza de que recojan la runa de bounty. Una vez que las runas se recogen, o después de un breve período, se completa una transferencia para cortar completamente el código del bot predeterminado y se define la función Think de bot_generic.<br/>
<br/>

## == Estado del proyecto ==
Versión Alfa. Por favor, proporciona comentarios (feedback).<br/>
¿Está estable el proyecto actualmente?: Experimental, actualizado para 7.34c 19/09/23 (19 de septiembre)<br/>
Última actualización de meta de DotaBuff: 19/09/23<br/>
<br/>

## == Soporte ==
Por favor, envíame un correo electrónico para cualquier pregunta o para apoyar el proyecto: <br/>
zyewchi@gmail.com<br/>

Si deseas apoyar el proyecto, mi PayPal está en el correo electrónico anterior con el icono del robot divertido. El apoyo significa que puedo justificar más tiempo para mejorarlos. Pero también solo un comentario amable en la página del taller ayuda mucho.

## == Contacto del desarrollador ==
Michael - zyewchi@gmail.com<br/>

---