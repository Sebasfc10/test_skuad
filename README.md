# Proyecto de Artículos Hacker News

## Descripción

Este proyecto es una aplicación desarrollada con Flutter que muestra una lista de artículos publicados en Hacker News relacionados con Mobile. Los artículos se obtienen a través de la API de Algolia.

## Requisitos

- Flutter SDK
- Dart SDK
- Conexión a Internet (para obtener artículos de la API)
- Cocoapods (para la configuración en dispositivos iOS)

## Instalación

1. **Clonar el Repositorio**

   Clona este repositorio a tu máquina local usando el siguiente comando:

   ```bash
   git clone <URL_DEL_REPOSITORIO>

## Desiciones Tomadas
- Patrón BLoC: Se tomó la decisión de utilizar el patrón BLoC ya que ofrece un entorno adecuado para manejar múltiples escenarios, por ejemplo, mostrar los artículos obtenidos en caso de error de conexión con la API. Para esta funcionalidad, se consideró almacenar inicialmente los artículos en SQLite para mostrarlos cuando no haya acceso a Internet.

- Arquitectura Limpia con BLoC: Se considero contruir la arquitectura de la app con arquitectura limpia con bloc, divide la logica de la presentacion esto permite que sea escalable y desacloplada para un facil mantenimiento, detalles: 

1. api_service.dart: Maneja las solicitudes a la API y la transformación de datos.
2. article_model.dart: Define el modelo de datos para los artículos.

- Configuración en iOS: Si la aplicación se ejecuta en dispositivos iOS, se recuerda tener Cocoapods instalado. En caso de errores al clonar el repositorio en un dispositivo iOS, se recomienda borrar el Podfile y el Podfile.lock, y volver a generarlos. También se recomienda abrir la carpeta Runner.xcworkspace en Xcode para una configuración adicional del entorno iOS de la aplicación.

## Pruebas
Se realizaron pruebas de widget para los siguientes componentes:

- ArticleItem
- AppBar
- CircularProgress
- Loading
Además, se realizaron pruebas para el método fetchArticles.

## Dependencias
1. Las siguientes dependencias fueron incluidas en el proyecto:

- http: Para realizar solicitudes HTTP.
- flutter_bloc: Para la gestión del estado.
- equatable: Para comparar objetos de manera fácil.
- sqflite: Para el almacenamiento local de datos.
- connectivity_plus: Para validar la conexión a Internet y mostrar datos cuando no se tenga acceso a Internet.

2. Para las pruebas:

- mockito y build_runner: Para generar mocks, especialmente para el testing de fetchArticles.
- bloc_test: Para pruebas concretas relacionadas con el estado y algunos widgets.
# test_skuad
# skuad_test
