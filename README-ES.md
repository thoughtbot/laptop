Laptop
======

Laptop es un script para configurar una laptop macOS para desarrollo web y móvil.
Puede ejecutarse múltiples veces en la misma computadora de forma segura.
Laptop instala, actualiza o salta paquetes
basándose en lo que ya está instalado en la computadora.

Requerimientos
--------------

Soportamos:

* macOS Mavericks (10.9)
* macOS Yosemite (10.10)
* macOS El Capitan (10.11)
* macOS Sierra (10.12)

Tal vez funcionen versiones antiguas, pero no son regularmente probadas.
Reportes de bugs para versiones anteriores son bienvenidos.

Instalación
-----------

Descarga el script:

```sh
curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
```

Revisa el script (evita ejecutar scripts que no haz leído!):

```sh
less mac
```

Ejecuta el script que descargaste:

```sh
sh mac 2>&1 | tee ~/laptop.log
```

Opcionalmente revisa el log:

```sh
less ~/laptop.log
```

Opcionalmente, [instala los thoughtbot/dotfiles][dotfiles].

[dotfiles]: https://github.com/thoughtbot/dotfiles/blob/master/README-ES.md

Depurando
---------

Tu última ejecución de Laptop se guardará en `~/laptop.log`.
Léela completamente para ver si puedes depurarlo.
Si no, copia las lineas en donde el script falló en un
[nuevo issue de GitHub](https://github.com/thoughtbot/laptop/issues/new) para nosotros.
O, envía el archivo completo del log como archivo adjunto.

Lo que configura
----------------

Herramientas macOS:

* [Homebrew] para adminsitrar las librerías operativas del sistema.

[Homebrew]: http://brew.sh/

Herramientas Unix:

* [Exuberant Ctags] para indexar archivos para que vim complete con tab
* [Git] para control de versiones
* [OpenSSL] para la seguridad de la capa de transporte (TLS – Transport Layer Security)
* [RCM] para administrar dotfiles de la compañía y personales
* [The Silver Searcher] para encontrar cosas en los archivos
* [Tmux] para guardar el estado de cada proyecto y cambiar de proyecto
* [Watchman] para ver cambios en los archivos del sistema
* [Zsh] como tu intérprete de comandos (shell)

[Exuberant Ctags]: http://ctags.sourceforge.net/
[Git]: https://git-scm.com/
[OpenSSL]: https://www.openssl.org/
[RCM]: https://github.com/thoughtbot/rcm
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Tmux]: http://tmux.github.io/
[Watchman]: https://facebook.github.io/watchman/
[Zsh]: http://www.zsh.org/

Herramientas de Heroku:

* [Heroku CLI] y [Parity] para interactuar con el API de Heroku

[Heroku CLI]: https://devcenter.heroku.com/articles/heroku-cli
[Parity]: https://github.com/thoughtbot/parity

Herramientas de GitHub:

* [Hub] para interactuar con el API de GitHub

[Hub]: http://hub.github.com/

Herramientas para Imágenes:

* [ImageMagick] para cortar y cambiar el tamaño de imágenes

Herramientas para pruebas:

* [Qt 5] para pruebas de JavaScript via [Capybara Webkit]

[Qt 5]: http://qt-project.org/
[Capybara Webkit]: https://github.com/thoughtbot/capybara-webkit

Lenguajes de programación, administradores de paquetes, y configuración:

* [ASDF] para administrar las versiones de los lenguajes de programación
* [Bundler] para administrar las librerías de Ruby
* [Node.js] y [NPM], para ejecutar apps e instalar paquetes de JavaScript
* [Ruby] estable para escribir código de uso en general
* [Yarn] para administrar los paquetes de JavaScript

[Bundler]: http://bundler.io/
[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[ASDF]: https://github.com/asdf-vm/asdf
[Ruby]: https://www.ruby-lang.org/en/
[Yarn]: https://yarnpkg.com/en/

Bases de datos:

* [Postgres] para almacenar datos relacionales
* [Redis] para almacenar datos llave-valor

[Postgres]: http://www.postgresql.org/
[Redis]: http://redis.io/

Debe tomar menos de 15 minutos para instalar (depende de tu computadora).

Personaliza en `~/.laptop.local`
------------------------------

Tu `~/.laptop.local` se ejecuta al final del script Laptop.
Pon tus personalizaciones ahí.
Por ejemplo:

```sh
#!/bin/sh

brew bundle --file=- <<EOF
brew "Caskroom/cask/dockertoolbox"
brew "go"
brew "ngrok"
brew "watch"
EOF

default_docker_machine() {
  docker-machine ls | grep -Fq "default"
}

if ! default_docker_machine; then
  docker-machine create --driver virtualbox default
fi

default_docker_machine_running() {
  default_docker_machine | grep -Fq "Running"
}

if ! default_docker_machine_running; then
  docker-machine start default
fi

fancy_echo "Cleaning up old Homebrew formulae ..."
brew cleanup
brew cask cleanup

if [ -r "$HOME/.rcrc" ]; then
  fancy_echo "Updating dotfiles ..."
  rcup
fi
```

Escribe tus personalizaciones par que puedan ser ejecutadas de forma
segura más de una vez
Ve el script `mac` para ejemplos.

Las funciones de Laptop como `fancy_echo` y
`gem_install_or_update`
pueden ser usadas en tu `~/.laptop.local`.

Ve el [wiki](https://github.com/thoughtbot/laptop/wiki)
para más ejemplos de personalización.

Contribuye
----------

Edita el archivo `mac`.
Documenta en el archivo `README.md`
Sigue la guía de estilo shell al utilizar [ShellCheck] y [Syntastic].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
[Syntastic]: https://github.com/scrooloose/syntastic

[Contribuyentes], Gracias!

[contribuyentes]: https://github.com/thoughtbot/laptop/graphs/contributors

Al participar en este proyecto,
estás de acuerdo en atenerte al [código de conducta] de thoughtbot.

[código de conducta]: https://thoughtbot.com/open-source-code-of-conduct

Licencia
-------

Laptop es © 2011-2017 thoughtbot, inc.
Es software gratuito,
y podrá ser redistribuido bajo los términos específicados en el archivo de la [LICENCIA]

[LICENCIA]: LICENSE

Acerca de thoughtbot
----------------

![thoughtbot](http://presskit.thoughtbot.com/images/thoughtbot-logo-for-readmes.svg)

Laptop es mantenido y fundado por thoughtbot, inc.
Los nombres y logos de thoughtbot son marcas registradas de thoughtbot, inc.

Somos apasionados acerca del software de fuente abierta.
Ve [nuestros otros proyectos][community].
Estamos [disponibles para ser contratados][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com?utm_source=github
