defmodule Weber.Word.Projector.Register do
  use Commanded.Projections.Ecto,
      name: "Weber.Projection.WordRegister",
      consistency: :strong

  project %Word.Events.Created{normalForm: normalForm, language: language} do
    Ecto.Multi.insert(multi, :wordRegister_projection, %Weber.WordRegister{normalForm: normalForm, language: language})
  end
 # def error({:error, :failed}, %Word.Events.Created{} = event, %FailureContext{context: context}) do
 #     context = record_failure(context)
 # end
end
