class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :search_id, :data

  def data
    {
     title: self.object.data['title'],
     author_name: self.object.data['author_name'],
     subject: self.object.data['subject'],
     laguage: self.object.data['language'],
     key: self.object.data['key']
    }
  end
end
