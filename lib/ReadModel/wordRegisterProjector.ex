defmodule Weber.WordRegisterProjector do
  use Commanded.Projections.Ecto, name: "wordRegister_projection"

  project %Word.Events.Created{normalForm: normalForm, language: language}, fn multi ->
    Ecto.Multi.insert(multi, :wordRegister_projection, %ExampleProjection{name: name})
  end
end
