module SalesHelper
  def active_sale?
    Sale.active.any?
  end
end

# The question marks in the query are placeholders and the arguements that come after the query will fill in the blanks in order of question marks