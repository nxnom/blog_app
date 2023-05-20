require 'swagger_helper'

RSpec.describe 'Comments', type: :request do
  path '/posts/{post_id}/comments' do
    get 'Retrieves comments' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :post_id, in: :path, type: :string, description: 'Post ID'

      response '200', 'Comments retrieved' do
        let(:post_id) { Post.create(title: 'Title', text: 'Text').id }
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   created_at: { type: :string, format: :date_time },
                   updated_at: { type: :string, format: :date_time },
                   post_id: { type: :integer }
                 },
                 required: %w[id text created_at updated_at post_id]
               }

        run_test!
      end
    end

    post 'Creates a comment' do
      tags 'Comments'
      description 'Creates a comment you need to be logged in to create a comment'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :post_id, in: :path, type: :string, description: 'Post ID'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: %w[text]
      }

      response '201', 'Comment created' do
        let(:post_id) { Post.create(text: 'Text').id }
        let(:comment) { { text: 'Text' } }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 text: { type: :string },
                 created_at: { type: :string, format: :date_time },
                 updated_at: { type: :string, format: :date_time },
                 post_id: { type: :integer },
                 user_id: { type: :integer }
               },
               required: %w[id text created_at updated_at post_id]

        run_test!
      end
    end
  end
end
