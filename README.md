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

'dotnet add package Microsoft.EntityFrameworkCore.SqlServer'

2. 
