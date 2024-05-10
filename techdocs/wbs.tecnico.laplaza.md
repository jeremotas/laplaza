# WBS Tecnico - La Plaza: la furia de las trenzas

* Juego
  * Game Stats
    * XP | seguimiento de experiencia
    * Nivel | Implementacion de formulas para control de nivel
    * HUD | Implementacion visual de información de juego
      * Indicador de nivel
      * Indicador de experiencia y proximo nivel
      * Reloj
      * Barra de vida de la plaza

  * Eventos 
    * EventTimer | Implementacion de eventos por tiempo
      * El pueblo | Agua hirviendo y cascotazos para limpiar la masividad de una ola.
      * La lluvia | Caida de agua hace que por un momento los enemigos se muevan mas lento.
      * El viento de cola | Viento fuerte que hace que los enemigos se muevan mas rapido.
    * Game Over | Condicion de final de juego (ganando y perdiendo)
  * EnemyTimer | Controlador del tiempo para gestion de enemigos
  * Screens
    * Menu | Implementacion de menu principal
    * Intro | Implementacion de pantalla de intro
    * Game Over | Implementacion de pantalla de fin de juego (perdedor)
    * Win | Implementacion de pantalla de fin de juego (ganador)
    * Creditos | Implementacion de pantalla de creditos
  * Easter eggs
    * La 12 | Implementacion de easter egg de la "moliendo cafe"
    * 912 | Implementacion de easter egg de la cancion "lo que quiere la chola"
  * Tilemap 
    * Terreno | Preparacion de terrero y sus formatos visuales
    * Edificaciones | Armado de edificaciones relevantes

* Jugador
  * El general | Implementacion de personaje principal, su ataque y sus animaciones (walk, idle, die)
  * Movimientos por teclado y joystick | Implementacion de movimientos axiales y diagonales
  * Movimientos por mouse | Implementacion de click y movimiento
  * Disparos automaticos 
    * Movimiento de proyectiles
    * Control de colisiones (evitar friendly fire)
    * Seleccion de objetivos
  * Malón
    * Composicion| Implementacion del grupo de soldados que siguen al general y su selección al progresar
    * Respawn | Cuando muere uno, debe reaparecer
  * Otros personajes
    * Etapa 1
      * Granaderos | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
      * Arribeños | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
      * Correntinos | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
      * Morenos | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
      * Artilleros | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
    * Etapa 2
      * Migueletes | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
      * Cazadores | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
      * Blandengues | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
      * Dragones | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
    

* Enemigos
  * Movimientos | Implementacion de movimientos de enemigos
  * Disparos 
    * Movimiento de proyectiles
    * Control de colisiones (evitar friendly fire)
    * Seleccion de objetivos
  * Otros enemigos
    * Ingleses | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
    * Caballeria | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die)
    * Miniboss | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die), incluido movimiento especial de camara.
    * Boss final | Implementacion de personaje, su ataque y sus animaciones (walk, idle, die), incluido movimiento especial de camara.

* Generales y entidades
  * Spawner | Deployer de unidades propias y de enemigos segun implementacion en nivel
  * Goals | Objetivo con contador de personajes ingresados
  * Characters | Contenedor de personajes propios y de enemigos
    * Arma y disparo
    * Vision
    * Colision propia
    * Colision enemiga
    * Recorrido
  * Grupos por facciones | Control de facciones (ingleses y patriotas)
  * Settings | Configuracion de palancas del juego via JSON