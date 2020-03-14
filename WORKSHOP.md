# Ruby desde 0 workshop

### 1. Instalación.

#### 1.1 Docker

- [Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)
- [MacOS](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
- Linux
  - [Ubuntu](https://hub.docker.com/editions/community/docker-ce-server-ubuntu)
  - [CentOS](https://hub.docker.com/editions/community/docker-ce-server-centos)
  - [Debian](https://hub.docker.com/editions/community/docker-ce-server-debian)
  - [Fedora](https://hub.docker.com/editions/community/docker-ce-server-fedora)

_Más opciones de instalación en [Docker Hub](https://hub.docker.com/search?q=&type=edition&offering=community)_

### 2. Correr un contenedor de Ruby

```bash
docker run -it --name ruby_workshop --mount type=bind,source="$(pwd)",target=/workspace ruby:2.7 bash
```

### 3. IRB (Interactive Ruby) shell.

```bash
irb
```

### 4. Ruby en 20 minutos

[Ruby en 20 minutos](https://www.ruby-lang.org/es/documentation/quickstart/)

### 5. Crear una imagen de Docker para Ruby on Rails

#### 5.1 Dockerfile

```Dockerfile
FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    yarn \
    && apt-get clean

WORKDIR /blog

RUN echo "gem: --no-document" > /root/.gemrc
RUN gem install rails bundler

VOLUME /usr/local/bundle

EXPOSE 3000

CMD bundle exec rails s -b 0.0.0.0
```

#### 5.2 Build de la imágen

```bash
docker build --tag rails_custom:latest .
```

#### 5.3 Creamos el proyecto en Rails

```bash
docker run -it --rm --mount type=bind,source="$(pwd)",target=/blog --mount type=volume,source=blog_bundle,target=/usr/local/bundle rails_custom:latest rails new .
```

#### 5.3 Corriendo un contenedor con la nueva imágen

```bash
docker run -it --name rails_workshop --mount type=bind,source="$(pwd)",target=/blog --mount type=volume,source=blog_bundle,target=/usr/local/bundle --publish 3000:3000 rails_custom:latest
```

#### 5.4 Ejecutando comandos dentro del contenedor

```bash
docker exec -it rails_workshop [command]
```

### 4. Getting Started with Rails

[Getting Started with Rails](https://guides.rubyonrails.org/getting_started.html)
