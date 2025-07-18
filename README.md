# Receitop Mobile Flutter

Este é o projeto frontend mobile "Receitop", desenvolvido em Flutter para a disciplina de Desenvolvimento Mobile, ministrada pelo Professor Pedro Feijó na Universidade Federal do Ceará (UFC), campus de Itapajé.

## Visão Geral

O Receitop é um aplicativo de receitas que permite aos usuários gerenciar suas receitas favoritas e explorar um catálogo de pratos. Ele se integra a uma API backend para a consulta dos dados.

## Tecnologias Utilizadas

*   **Flutter**: Framework de UI para construção de aplicativos compilados nativamente para mobile, web e desktop a partir de uma única base de código.
*   **Dart**: Linguagem de programação utilizada pelo Flutter.
*   **Ferramenta Auxiliar**: Android Studio.

## Funcionalidades Principais

*   **Autenticação**: Registro e Login de usuários.
*   **Gerenciamento de Receitas**:
    *   Visualização de detalhes de receitas.
*   **Exploração**: Página inicial para descobrir receitas.
*   **Perfil do Usuário**: Gerenciamento de informações do perfil.
*   **Favoritos**: Seção para gerenciar receitas favoritas.

## Estrutura do Projeto

O projeto segue uma estrutura modular, com funcionalidades divididas em `features` (auth, favorites, home, profile, recipes) e componentes comuns em `common/widgets`.

```
lib/
├── app_shell.dart
├── main.dart
├── common/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── login/
│   │   ├── register/
│   │   └── services/
│   ├── favorites/
│   ├── home/
│   ├── profile/
│   └── recipes/
│       ├── create/
│       └── details/
```

## Configuração e Execução

### Pré-requisitos

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
*   Um emulador Android/iOS ou dispositivo físico configurado.
*   A API backend (`receitop-api`) deve estar em execução e acessível. O projeto da API pode ser encontrado em: [https://github.com/NelsonFelipe/receitop-api](https://github.com/NelsonFelipe/receitop-api)

### Passos para Executar

1.  **Navegue até o diretório do projeto:**

    ```bash
    cd receitop_mobile_flutter
    ```

2.  **Instale as dependências:**

    ```bash
    flutter pub get
    ```

3.  **Configure a URL da API:**
    A URL base da API está definida em `lib/main.dart` como `http://10.0.2.2:3333`. Se sua API estiver em um endereço diferente (por exemplo, rodando em `localhost` na sua máquina, que para o emulador Android é `10.0.2.2`), você pode precisar ajustar esta URL.

    ```dart
    // lib/main.dart
    void main() {
      const String baseUrl = 'http://10.0.2.2:3333'; // Altere conforme necessário
      // ...
    }
    ```

4.  **Execute o aplicativo:**

    ```bash
    flutter run
    ```

    O aplicativo será iniciado no emulador ou dispositivo conectado.

## Contribuição

Para contribuir com o projeto, siga as boas práticas de desenvolvimento Flutter e Dart. Crie branches para novas funcionalidades ou correções de bugs e envie Pull Requests.

## Licença

Este projeto está licenciado sob a licença [MIT](LICENSE).
