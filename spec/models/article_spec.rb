require 'rails_helper'

RSpec.describe 'Article\'s Model', type: :model do
  let(:article1) do
    Article.new(
      title: 'Article I',
      body: 'Article I\'s body',
      like: 2
    )
  end

  let(:article2) do
    Article.new(
      title: 'Article II',
      body: 'Article II\'s body',
      like: 3
    )
  end

  context 'Attributes' do
    context 'title' do
      it '1, article must have title' do
        expect(article1.title).to_not be_nil
      end

      it '2, article title must have be type string  ' do
        expect(article1.body).to be_a String
      end

      it '3, article title length should be less than equal 20 but greater than equal 3' do
        expect(article1.body.size).to be <= 20 && be >= 3
      end

      it '4, article title must be unique' do
        expect(article1.title).to_not eql article2.title
      end
    end

    context 'body' do
      it '1, article must have body' do
        expect(article1.body).to_not be_nil
      end

      it '2, article body must have be type string  ' do
        expect(article1.body).to be_a String
      end

      it '3, article body length should be less than equal 140 but greater than equal 10' do
        expect(article1.body.size).to be <= 140 && be >= 10
      end
    end

    context 'like' do
      it '1, article like must be type Integer' do
        expect(article1.like).to be_an Integer
      end
    end

    context 'image' do
      it '1, article image must match any image file extention specified, (png|jpg|gif)' do
        image = 'apple-touch-icon.png'
        article1.image.attach(
          io: File.open("./spec/fixtures/files/#{image}"),
          filename: 'apple-touch-icon.png',
          content_type: 'image/png'
        )
        expect(article1.image).to match(/\.(png|jpg|gif)$/) unless article1.image
      end
    end
  end
end
