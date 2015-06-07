class Comment
  include Mongoid::Document
  field :body, type: String
  embedded_in :issue
end
