WebTemplate::App.controllers :tags, :provides => [:json] do
  get :show, :map => '/tags', :with => :id do
    begin
      tag_id = params[:id]
      tag = tag_repo.find(tag_id)

      tag_to_json tag
    rescue ObjectNotFound => e
      status 404
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/tags' do
    begin
      tag = Tag.new(tag_params[:tag_name])
      new_tag = tag_repo.save(tag)

      status 201
      tag_to_json new_tag
    rescue InvalidTag => e
      status 400
      {error: e.message}.to_json
    end
  end
end
