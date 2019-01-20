defmodule Weber.CLI do
  @moduledoc """
  Command line interface to weber application.
  """

  @doc """
  Provides dictionary functionality similar to merriam-webster
  Application can add words with information or
  fetch existing words.

  type ./weber --help to get a full description

  during execution of any command uknown words will be created

  ## Examples

      > ./weber create hello "a common welcome"
      > ./weber describe hello  "a common greeting used to start the communication"
      > ./weber examples hello "1) Hello, buddy \n 2) He even did not say hello to me"
      > ./weber illustrate hello ".\hello.jpg"
      > ./weber synonym hello hi
      > ./weber antonym hello bye
      > ./weber show hello

  """
  def main(args \\ []) do
    examples_argument =
    [
      value_name: "<examples>",
      help: "Examples for word usage",
      required: false,
      parser: :string
    ]

    description_argument =
    [
      value_name: "<description>",
      help: "Word's description",
      required: false,
      parser: :string
    ]

    word_argument =
    [
      value_name: "<word>",
      help: "Word's normal form",
      required: true,
      parser: :string
    ]

    illustration_argument =
    [
      value_name: "illustration",
      help: "A path to local image file to add as illustration for the word",
      required: false,
      parser: :string
    ]

    Optimus.new!(
      name: "Weber",
      description: "A simple dictionary application",
      version: "1.0.0",
      author: "andrey.leskov@gmail.com",
      about: "Utility to create and use a dictionary storing information in PostgreSQL.
all commands will add uknown words to the dictionary",
      allow_unknown_args: false,
      parse_double_dash: true,
      subcommands: [
        show: [
          name: "show",
          about: "Display information about a word or dictionary content",
          args: [
            word:  [
              value_name: "<word>",
              help: "Word's normal form. If not presented, command will display dictionary content",
              required: false,
              parser: :string
            ]
          ],
        ],
        create: [
          name: "create",
          about: "Creates a new word",
          args: [
            word:  word_argument
          ],
        ],
        describe: [
          name: "describe",
          about: "Describes a word",
          args: [
            word: word_argument,
            description: Keyword.put(description_argument, :required, true)
          ]
        ],
        examples: [
          name: "examples",
          about: "Provide examples for a word",
          args: [
            word: word_argument,
            examples: Keyword.put(examples_argument, :required, true)
          ]
        ],
        illustrate: [
          name: "illustrate",
          about: "Add an illustration for a word",
          args: [
            word: word_argument,
            illustration: Keyword.put(illustration_argument, :required, true)
          ]
        ],
        synonym: [
          name: "synonym",
          about: "Adds a synonym to a word",
          args: [
            word: word_argument,
            synonym: [
              value_name: "<synonym>",
              help: "A word to add as a synonym",
              required: true,
              parser: :string
            ]
          ]
        ],
        antonym: [
          name: "antonym",
          about: "Adds an antonym to a word",
          args: [
            word: word_argument,
            antonym: [
              value_name: "<antonym>",
              help: "A word to add as an antonym",
              required: true,
              parser: :string
            ]
          ]
        ]
      ]
    ) |> Optimus.parse!(args) |> Weber.CLI.Executor.execute
  end
end
