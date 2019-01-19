defmodule Weber.CLI do
  @moduledoc """
  Command line interface to weber application.
  """

  @doc """
  Provides dictionary functionality similar to merriam-webster
  Application can add words with information or
  fetch existing words.

  type ./weber --help to get a full description

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
      value_name: "examples",
      help: "Examples for word usage",
      required: false,
      parser: :string
    ]

    description_argument =
    [
      value_name: "description",
      help: "Word's description",
      required: false,
      parser: :string
    ]

    word_argument =
    [
      value_name: "word",
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
      about: "Utility to create and use a dictionery storing information in PostgreSQL",
      allow_unknown_args: false,
      parse_double_dash: true,
      subcommands: [
        show: [
          name: "show",
          about: "Display information about a word or available words in dictionaty",
          args: [
            word:  Keyword.put(word_argument, :required, false)
          ],
        ],
        create: [
          name: "create",
          about: "Creates a new word",
          args: [
            word:  word_argument
            #TODO: add as flags for better UX
            #description: description_argument,
            #examples: examples_argument,
            #illustration: illustration_argument
          ],
        ],
        describe: [
          name: "describe",
          about: "Describes an existing word",
          args: [
            word: word_argument,
            description: Keyword.put(description_argument, :required, true)
          ]
        ],
        examples: [
          name: "examples",
          about: "Provide examples for an existing word",
          args: [
            word: word_argument,
            examples: Keyword.put(examples_argument, :required, true)
          ]
        ],
        illustrate: [
          name: "illustrate",
          about: "Provide an illustration for an existing word",
          args: [
            word: word_argument,
            illustration: Keyword.put(illustration_argument, :required, true)
          ]
        ],
        synonym: [
          name: "synonym",
          about: "Adds a synonym to an existing word",
          args: [
            word: word_argument,
            synonym: [
              value_name: "synonym",
              help: "A word to add as a synonym to current word",
              required: true,
              parser: :string
            ]
          ]
        ],
        antonym: [
          name: "antonym",
          about: "Adds an antonym to an existing word",
          args: [
            word: word_argument,
            antonym: [
              value_name: "antonym",
              help: "A word to add as an antonym to current word",
              required: true,
              parser: :string
            ]
          ]
        ]
      ]
    ) |> Optimus.parse!(args) |> Weber.CLI.Executor.execute
  end
end
