# Aplicación de Séneca Registros del baño

Una aplicación web destinada al profesorado para hacer un registro de los alumnos que van al baño.

## Funcionamiento

Este proyecto consiste en controlar y registrar la información de cada uno de los alumnos que van al baño, para poder sacar unas conclusiones de esos registros y trabajarla para ver si existe un problema con alguno de ellos y contactar con la familia.

Dicha información se envía a la hoja de cálculo de Google Sheets, utilizando una página web para las llamadas a la aplicación llamado Google Apps Script.

El acceso a la aplicación web es a través de una cuenta de Google que esté autorizado para entrar. Este sistema utiliza Firebase, el que gestiona las sesiones iniciadas dentro de la aplicación.

## Requisitos

Para este proyecto se necesitan los siguientes elementos:
- Un ID del cliente de Google para poder iniciar sesión a través de la página web.
- Un ordenador con IDE destinado para utilizar lenguajes de programación en el proyecto (Dart, Visual Studio Code) y conexión a Internet para realizar las peticiones.

## Instalación

Para instalar y configurar el proyecto de la aplicación web del registro de baños, debemos seguir los siguientes pasos:

1. Instalar el paquete de [Flutter](https://docs.flutter.dev/get-started/install) y agregarlo al PATH del sistema.

2. Instalar el [Node.js](https://nodejs.org/es) para poder usar los comandos npm.

3. Instalar los paquetes del Firebase para el proyecto.
```
npm install -g firebase-tools
```
4. Iniciar sesión con una cuenta de Google que usamos para conectar al proyecto con Firebase
```
firebase login
```

