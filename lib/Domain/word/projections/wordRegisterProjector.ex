defmodule Weber.Projector.WordRegister do
  import Ecto.Changeset
  alias Weber.Projection.WordRegister

  use Commanded.Projections.Ecto,
      name: "Weber.Projector.WordRegister",
      consistency: :strong

  project %Word.Events.Created{word: word, description: description} do
    Ecto.Multi.insert(multi, :word_register, %Weber.Projection.WordRegister{normalForm: word, description: description})
  end

  project %Word.Events.Described{word: word, description: description} do
    update_word(multi, word, description: description)
  end

  project %Word.Events.Illustrated{word: word, illustration: %Word.Image{binary: binary, mime: mime}} do
    update_word(multi, word, illustration_binary: binary, illustration_mime: mime)
  end

  defp update_word(multi, normalForm, changes) do
    Ecto.Multi.update_all(multi, :word_register, word_query(normalForm), set: changes)
  end

  defp word_query(word) do
    from(w in WordRegister, where: w.normalForm == ^word)
  end

  project %Word.Events.ExamplesProvided{word: word, examples: examples} do
    update_word(multi, word, examples: examples)
  end
end
