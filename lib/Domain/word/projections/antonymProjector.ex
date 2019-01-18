defmodule Weber.Word.Projections.Antonym.Projector do
  use Commanded.Projections.Ecto,
      name: "Weber.Word.Projections.Antonym.Projector",
      consistency: :strong

  project %Word.Events.AntonymAdded{word: word, antonym: antonym} do
    Ecto.Multi.insert(multi, :synonyms, %Weber.Word.Projection.Antonym{word: word, antonym: antonym})
  end
end
