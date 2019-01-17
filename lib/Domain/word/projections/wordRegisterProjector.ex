defmodule Weber.Projector.WordRegister do
  use Commanded.Projections.Ecto,
      name: "Weber.Projector.WordRegister",
      consistency: :strong

  project %Word.Events.Created{word: word, language: language} do
    Ecto.Multi.insert(multi, :word_register, %Weber.Projection.WordRegister{normalForm: word, language: language})
  end
 # def error({:error, :failed}, %Word.Events.Created{} = event, %FailureContext{context: context}) do
 #     context = record_failure(context)
 # end
end
