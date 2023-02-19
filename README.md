# Aplicativo da Lista de Compras

Projeto final do curso *Curso de Flutter: Módulo Avançado* oferecido pelo Núcleo de Estudos sobre Mobilidade Sustentável (NEMOBIS) da [UDESC](https://www.udesc.br/). O projeto foi focado em Android

# :hammer: Funcionalidades do projeto

- `Funcionalidade 1`: Permitir que o usuário tire uma foto do item ao qual ele deseja adicionar a lista.
- `Funcionalidade 2`: que o usuário visualize uma prévia da foto do item ao exibir todos os itens
cadastrados na lista de compras.
- `Funcionalidade 3`: Permitir que sejam enviados notificações de tempos em tempos para que o usuário volte
a usar o aplicativo.
- `Funcionalidade 3`: Permitir configurar o período de tempo em que as notificações são enviadas.
- `Funcionalidade 4`: Utilizar o SQFLite (ou outro banco SQL) para salvar e carregar do banco de dados as
informações da lista de compras.
- `Funcionalidade 5`: Permitir que um item seja excluído do banco de dados.
- `Funcionalidade 6`: Definir um ícone e um nome para o aplicativo no AndroidManifest.xml, compilando o
aplicativo e gerando um .apk.

# :package: Pacotes utilizados

- `Location`: ao salvar um novo item na lista de compras, a latitude e longitude do
usuário deve ser obtida e salva junto.
- `Shared Preferences`: o período de tempo em que novas notificações são enviadas deve
ser salvo utilizando esse pacote.
- `Local Notification`: deve ser utilizado para agendar notificações que tragam o usuário
ao aplicativo de tempos em tempos.
- `SQFLite ou BD SQL similar`: todas as informações referentes a lista de compras deve
ser salva em um banco de dados local.
- `Flutter Icons`: utilize para definir o ícone da aplicação.

## License

Este projeto tem a licença [MIT](./License).
