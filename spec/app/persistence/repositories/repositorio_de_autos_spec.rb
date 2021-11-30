require 'integration_helper'

describe Persistence::Repositories::RepositorioDeAutos do
  let(:repo_autos) { Persistence::Repositories::RepositorioDeAutos.new }
  let(:auto) { Auto.new("fiat", 'uno', 1999, "MFS222", 1) }

  before do
    repo_autos.delete_all
  end

  it 'Al crear un auto debería tener cantidad 1' do
    repo_autos.save(auto)
    expect(repo_autos.all.count).to eq(1)
  end

end
