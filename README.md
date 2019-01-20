# Weber

Weber is an assesmenet task used to demonstrate coding skills for Elixir and some practicies, like DDD, ES, and CQRS
It is a command line-based dictionary application, similar to https://www.merriam-webster.com/
Functionalty available:

* Look up a word and show some explanations
* Show example sentences 
* Show synonyms and antonyms 
* Record lookup history in PostgreSQL
* Show illustrations 

## Setup guide 

### Prerequirements 

* PostgreSQL
* ImageMagick
(you can check ImageMagick availability by running 'display' command in shell)

### Setup
1) Check out latest master branch
2) Update postgreSQL config in config/config.exs
 there are two entries: 
 * Jornal (write model) 
    ```elixir
    config :eventstore, EventStore.Storage,
        serializer: Commanded.Serialization.JsonSerializer,
        username: "postgres",
        password: "postgres",
        database: "weber_dev",
        hostname: "localhost",
    ```
 * Projections (read model)
    ```elixir
        config :weber, Weber.Projection.Repo,
            database: "weber_read",
            username: "postgres",
            password: "postgres",
            hostname: "localhost"
    ```
    Please configure different databases for each entry to avoid conflicts during ecto migrations 
3) Initialize databases by running commands 
    ```
    mix ecto.migrate
    mix do event_store.create, event_store.init 
    ```
4) Seed example data
    ```
    ./seed.sh
    ```
5) Compile project 
    ```
    MIX_ENV=prod mix escript.build
    ```
    If you prefer development configuration and want to see some internal logs, 
  compile project as 
    ```
    mix escript.build
    ```
6) Run application and read help

    ```
    ./weber --help
    ```

   Some 3dparty libraries used in weber will pollute console output with IO.warn messages. Please send me a message or create a new issue if you know how to suppress  it for production environment.

7) Try some predifined words like 
  ```
   ./weber show horse 
  ```
  or
  ```
   ./weber show absent 
  ```
  or 
  ```
   ./weber show example 
  ```
  or 
  ```
   ./weber show cat
  ```  
