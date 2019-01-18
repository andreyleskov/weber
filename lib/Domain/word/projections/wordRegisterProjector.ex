defmodule Weber.Projector.WordRegister do
  use Commanded.Projections.Ecto,
      name: "Weber.Projector.WordRegister",
      consistency: :strong

  project %Word.Events.Created{word: word, description: description} do
    Ecto.Multi.insert(multi, :word_register, %Weber.Projection.WordRegister{normalForm: word, description: description})
  end
end
