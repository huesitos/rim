class Comment
  include Mongoid::Document
  field :body, type: String
  field :date, type: Date
  
  embedded_in :issue
end
