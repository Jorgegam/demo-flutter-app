FROM ubuntu:22.04 AS builder
 
# Instalar dependencias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*
 
# Crear usuario no-root
RUN useradd -ms /bin/bash flutteruser
USER flutteruser
WORKDIR /home/flutteruser
 
# Clonar Flutter
RUN git clone --depth 1 https://github.com/flutter/flutter.git  flutter-sdk
 
# Agregar Flutter al PATH
ENV PATH="/home/flutteruser/flutter-sdk/bin:/home/flutteruser/flutter-sdk/bin/cache/dart-sdk/bin:${PATH}"
 
# Configuración
RUN flutter doctor
RUN flutter config --enable-web
 
# Se mueve a la carpeta app y se copian los archivos y paquetes necesarios
WORKDIR /home/flutteruser/app
COPY pubspec.yaml .
COPY lib/ lib/
COPY web/ web/
 
# Se instalan dependencias
RUN flutter pub get -v
# Se crea proyecto compilado
RUN flutter build web
 
FROM nginx:1.29-alpine3.23
COPY --from=builder /home/flutteruser/app/build/web /usr/share/nginx/html
 
EXPOSE 80
 
CMD ["nginx", "-g", "daemon off;"]
