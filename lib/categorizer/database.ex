use Amnesia

defdatabase Categorizer.Database do
  deftable Category, [{:id, autoincrement}, :name, :ancestry], type: :ordered_set
end
