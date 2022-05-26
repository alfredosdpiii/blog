require 'rails_helper'

RSpec.describe 'Article\'s Request', type: :request do
  describe 'GET' do
    describe '/articles/new' do
      before(:each) do
        get '/articles/new'
      end
      it 'success response' do
        expect(response).to have_http_status(200)
      end
      it 'render template new' do
        expect(response).to render_template(:new)
      end
    end

    describe '/articles/:id/edit' do
      before(:each) do
        article = Article.create(title: 'Article X', body: 'Article X\'s Body')
        get "/articles/#{article.id}/edit"
      end
      it 'success response' do
        expect(response).to have_http_status(200)
      end
      it 'render template edit' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST' do
    describe '/articles' do
      before(:each) do
        get '/articles'
      end
      it 'creates a new article' do
        post '/articles', params: {
          article: {
            title: 'Article V',
            body: 'Article V\'s body'
          }
        }
      end
      it 'redirect response' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
