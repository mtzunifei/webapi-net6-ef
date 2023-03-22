# webapi-net6-ef
WebApi com NET 6.0 e EF

.NET 6.0 - CRUD API - Exemplo e Tutorial

Neste tutorial, mostraremos como criar uma API .NET 6.0 compatível com operações CRUD. A API de exemplo inclui rotas para recuperar, atualizar, criar e excluir registros no banco de dados, os registros no aplicativo de exemplo são para usuários, mas isso é apenas para fins de demonstração, o mesmo padrão CRUD e estrutura de código podem ser usados para gerenciar qualquer tipo de dados, por exemplo produtos, serviços, artigos etc.

## EF Core InMemory database usado para teste

Para manter o código da API o mais simples possível, ele é configurado para usar o provedor de banco de dados EF Core InMemory, que permite que o Entity Framework Core crie e conecte-se a um banco de dados na memória, em vez de você precisar instalar um servidor de banco de dados real. Isso pode ser facilmente transferido para um provedor de banco de dados real quando você estiver pronto para trabalhar com um banco de dados como SQL Server, Oracle, MySQL etc. Para obter instruções sobre como conectá-lo a um banco de dados SQL Server veja o exemplo abaixo:

### Ferramentas necessárias

- .NET SDK - inclui o tempo de execução .NET e as ferramentas de linha de comando.
- Visual Studio Code - editor de código que roda em Windows, Mac e Linux. Se você tiver um editor de código preferido diferente, tudo bem também.
- Extensão C# para Visual Studio Code - adiciona suporte ao VS Code para desenvolver aplicativos .NET.
- SQL Server - você precisará acessar a instância do SQL Server em execução para a API se conectar remotamente ou em sua máquina local.

1. Update .NET API to use SQL Server

Adicionar provedor de banco de dados do SQL Server do NuGet.
Execute o seguinte comando da pasta raiz do projeto para instalar o provedor de banco de dados EF Core para SQL Server do NuGet:

```dotnet add package Microsoft.EntityFrameworkCore.SqlServer```

2. Adicionar cadeia de conexão às configurações do aplicativo.

Abra o arquivo appsettings.json e adicione a entrada "ConnectionStrings" com uma entrada filha para a string de conexão do SQL Server (por exemplo, "WebApiDatabase"), a string de conexão deve estar no formato "Data Source=[DB SERVER URL]; Initial Catalog =[DB NAME]; User Id=[USERNAME]; Password=[PASSWORD]", ou para se conectar com a mesma conta que está executando a API .NET, use o formato de string de conexão "Data Source=[DB SERVER URL]; Initial Catalog=[DB NAME]; Integrated Security=true".

Quando as migrações do EF Core geram o banco de dados, o valor do Catálogo Inicial será o nome do banco de dados criado no SQL Server.

O arquivo appsettings.json atualizado com a string de conexão deve se parecer com isto:

```
{
    "ConnectionStrings": {
        "WebApiDatabase": "Data Source=localhost; Initial Catalog=dotnet-5-crud-api; User Id=testUser; Password=testPass123"
    },
    "Logging": {
        "LogLevel": {
            "Microsoft": "Warning",
            "Microsoft.Hosting.Lifetime": "Information"
        }
    }
}
'{
    "ConnectionStrings": {
        "WebApiDatabase": "Data Source=localhost; Initial Catalog=dotnet-6-crud-api; User Id=testUser; Password=testPass123"
    },
    "Logging": {
        "LogLevel": {
            "Microsoft": "Warning",
            "Microsoft.Hosting.Lifetime": "Information"
        }
    }
}
```

3. Atualize o contexto de dados para usar o SQL Server
A classe DataContext localizada em /Helpers/DataContext.cs é usada para acessar os dados do aplicativo por meio do Entity Framework. Ele deriva da classe Entity Framework DbContext e possui uma propriedade pública Users para acessar e gerenciar dados do usuário.

Atualize o método OnConfiguring() para se conectar ao SQL Server em vez de um banco de dados na memória substituindo opções.UseInMemoryDatabase("TestDb"); com with options.UseSqlServer(Configuration.GetConnectionString("WebApiDatabase"));.

A classe DataContext atualizada deve ficar assim:

```
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using WebApi.Entities;

namespace WebApi.Helpers
{
    public class DataContext : DbContext
    {
        protected readonly IConfiguration Configuration;

        public DataContext(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            // connect to sql server with connection string from app settings
            options.UseSqlServer(Configuration.GetConnectionString("WebApiDatabase"));
        }

        public DbSet<User> Users { get; set; }
    }
}
```

4. Criar banco de dados SQL a partir do código com migrações do EF Core

Instalar ferramentas dotnet ef

As ferramentas .NET Entity Framework Core (dotnet ef) são usadas para gerar migrações do EF Core, para instalar as ferramentas EF Core globalmente, execute dotnet tool install -g dotnet-ef ou para atualizar, execute dotnet tool update -g dotnet-ef. Para obter mais informações sobre as ferramentas do EF Core, consulte https://docs.microsoft.com/ef/core/cli/dotnet

5. Adicione o pacote EF Core Design do NuGet
Execute o seguinte comando da pasta raiz do projeto para instalar o pacote de design do EF Core, ele fornece suporte a ferramentas de linha de comando entre plataformas e é usado para gerar migrações do EF Core:

```dotnet add package Microsoft.EntityFrameworkCore.Design```

6. Gerar migrações do EF Core

Gere novos arquivos de migração do EF Core executando o comando dotnet ef migrations add InitialCreate da pasta raiz do projeto (onde o arquivo WebApi.csproj está localizado), essas migrações criarão o banco de dados e as tabelas para a API do .NET Core.

7. Executar migrações do EF Core

Execute o comando dotnet ef database update da pasta raiz do projeto para executar as migrações do EF Core e criar o banco de dados e as tabelas no SQL Server.

Verifique o SQL Server e agora você deve ver seu banco de dados com as tabelas Users e __EFMigrationsHistory.

8. Reinicie a API .NET CRUD

Pare e reinicie a API com o comando dotnet run da pasta raiz do projeto, você deverá ver a mensagem Now listening on: http://localhost:4000 e a API agora deve estar conectada ao SQL Server.

### NET 6.0 CRUD Conteúdo 
- Ferramentas necessárias para desenvolver aplicativos .NET 6.0
- Execute a API de exemplo CRUD localmente
- Teste a API com Postman
- Estrutura do projeto do tutorial do .NET 6.0

1. Ferramentas necessárias para executar a API do tutorial .NET 6.0 localmente
Para desenvolver e executar aplicativos .NET 6.0 localmente, baixe e instale o seguinte:

- .NET SDK - inclui o tempo de execução .NET e as ferramentas de linha de comando
- Visual Studio Code - compilador de código que roda em Windows, Mac e Linux
- Extensão C# para Visual Studio Code - adiciona suporte ao VS Code para desenvolver aplicativos .NET

2. Execute a API de exemplo CRUD do .NET 6.0 localmente

- Baixe ou clone o código do projeto
- Inicie a API executando dotnet run a partir da linha de comando na pasta raiz do projeto (onde o arquivo WebApi.csproj está localizado), você deverá ver a mensagem - - Agora ouvindo em: http://localhost:4000.

3. Rode a coleção do postman disponível na raiz do projeto para testar.

4. Estrutura do projeto da API CRUD .NET 6.0.

O projeto do tutorial .NET CRUD está organizado nas seguintes pastas:

Controllers

Defina os pontos finais/rotas para a API da Web, os controladores são o ponto de entrada na API da Web a partir de aplicativos cliente por meio de solicitações http.

Models

Representa modelos de solicitação e resposta para métodos do controlador, modelos de solicitação definem parâmetros para solicitações recebidas e modelos de resposta definem dados personalizados retornados em respostas quando necessário. O exemplo contém apenas modelos de solicitação porque não contém nenhuma rota que exija modelos de resposta personalizados, as entidades são retornadas diretamente pelas rotas GET do usuário.

Services

Contém lógica de negócios, validação e código de acesso ao banco de dados.

Entities

Representa os dados do aplicativo armazenados no banco de dados.
Entity Framework Core (EF Core) mapeia dados relacionais do banco de dados para instâncias de objetos de entidade C# a serem usados ​​no aplicativo para gerenciamento de dados e operações CRUD.


Helpers

Qualquer coisa que não caiba nas pastas acima.

```
Controllers
- UsersController.cs
Entities
- Role.cs
- User.cs
Helpers
- AppException.cs
- AutoMapperProfile.cs
- DataContext.cs
- ErrorHandlerMiddleware.cs
Models
- Users
- CreateRequest.cs
- UpdateRequest.cs
Services
- UserService.cs
appsettings.json
Program.cs
WebApi.csproj
```
