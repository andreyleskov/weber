# Weber

Weber is an assesmenet task used to demonstrate coding skills in Elixir 
as well as some practicies, like DDD, ES, and CQRS
It is a command line-based dictionary application, similar to https://www.merriam-webster.com/

Weber provides a simple functionality

* Add new word entries and fill it with information
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
2) Update PostgreSQL config in config/config.exs.
   There are two entries: 
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
    Please use two different databases for Journal and Projections to avoid conflicts during ecto migrations 

3) Initialize databases by running commands 
    ```
    mix do ecto.create, ecto.migrate
    mix do event_store.create, event_store.init 
    ```
4) Compile project 
    ```
    MIX_ENV=prod mix escript.build
    ```
    If you prefer development configuration and want to see some internal logs, 
    please compile project for Dev environment 
    ```
    mix escript.build
    ```

5) Seed example data
    ```
    ./seed.sh
    ```
   Seed script will use weber app to fill the data into database

6) Run application and read help

    ```
    ./weber --help
    ```

   Some 3dparty libraries used in weber will pollute console output with IO.warn messages. Please send me a message or create a new issue if you know how to suppress  it for production environment.

7) Try some predifined words like 
  ```
   ./weber show horse 
   ./weber show absent 
   ./weber show cat
  ```  
8) To clean up database just run tests
  ```
  mix test
  ```
