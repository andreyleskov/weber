defmodule Weber.Word.Projections.Synonym.Projector do
  use Commanded.Projections.Ecto,
      name: "Weber.Word.Projections.Synonym.Projector",
      consistency: :strong

  project %Word.Events.SynonymAdded{word: word, synonym: synonym} do
    Ecto.Multi.insert(multi, :synonyms, %Weber.Word.Projection.Synonym{word: word, synonym: synonym})
  end
end
