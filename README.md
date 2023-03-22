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

''
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
'

