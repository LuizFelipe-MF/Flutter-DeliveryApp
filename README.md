<img src="https://github.com/LuizFelipe-MF/Flutter-DeliveryApp/blob/main/readme_images/BannerSVG.svg" width="100%" height="200">

## Delivery App

O Delivery App é um projeto que foi desenvolvido durante a Dart Week 9 da Academia do Flutter.

O app se baseia em um aplicativo de delivery de um restaurante de hamburguer (Vakinha Burguer).

## Tecnologia

Foi utilizado nessa aplicação as seguintes tecnologias.

- Flutter: versão 3.7.0.

## Funcionalidades

- Criar uma conta.
- Fazer sacola de compras.
- Realizar pedido.

## Como rodar o projeto no seu computador

1. Vá até o arquivo ```app/.env``` e altere o ip para o ip local da sua máquina.
```
backend_base_url=http://SEU_IP_LOCAL:8080 
```
2. Ative o json_rest_server pelo pub.
```
dart pub global activate json_rest_server
```
3. Abra um novo terminal e digite os seguintes comandos:
```
cd .\dw_delivery_api
json_rest_server run
```
4. Agora que o seu backend está funcionando, basta rodar a sua aplicação Flutter normalmente.

## Versão do projeto

### 1.0.0

## Feito por

- **Luiz Felipe**: @LuizFelipe-MF (https://github.com/LuizFelipe-MF)
