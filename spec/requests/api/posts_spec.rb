require 'swagger_helper'

RSpec.describe 'Posts', type: :request do
  path '/users/{user_id}/posts' do
    get 'Retrieves posts' do
      tags 'Posts'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, in: :path, type: :string, description: 'User ID'

      response '200', 'Posts retrieved' do
        let(:user_id) { User.create(name: 'John').id }
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   created_at: { type: :string, format: :date_time },
                   updated_at: { type: :string, format: :date_time },
                   author_id: { type: :integer }
                 },
                 required: %w[id title content created_at updated_at user_id]
               }

        run_test!
      end
    end
  end
end
