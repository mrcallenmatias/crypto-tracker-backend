require 'rails_helper'

RSpec.describe "Cryptos", type: :request do
  describe "GET /index" do
    it "gets a list of cryptos" do
    Crypto.create(
      name: "Bitcoin",
      age: 13,
      creator: "Satoshi Nakamoto",
      image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
    )
    get '/cryptos'
    crypto = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(crypto.length).to eq 1
    end 
  end
  describe "POST /create" do
    it "creates a crypto" do
      crypto_params = {
        crypto: {
          name: "Angular",
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
    }
    post '/cryptos', params: crypto_params
    expect(response).to have_http_status(200)
    crypto = Crypto.first
    expect(crypto.name).to eq 'Angular'
    end 
  end

  describe "PATCH /update" do
    it "updates a crypto" do
      old_crypto = Crypto.create(
          name: "Angular",
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      )
      crypto_params = {
        crypto: {
          name: "Angular",
          age: 14,
          creator: "TSatoshi Nakamotooo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
      }
    patch "/cryptos/#{old_crypto.id}", params: crypto_params
    crypto = Crypto.find(old_crypto.id)
    expect(response).to have_http_status(200)
    expect(crypto.creator).to eq 'TSatoshi Nakamotooo'
    end 
  end 
  describe "DELETE /destroy" do
    it "deletes a crypto from the database" do
      old_crypto = Crypto.create(
        name: "Angular",
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      )
      delete "/cryptos/#{old_crypto.id}"
      expect(response).to have_http_status(200)
      cryptos = Crypto.all
      expect(cryptos).to be_empty
    end 
  end

  # For Validation
  describe  'request validations' do
    it 'does not create crypto without name' do
      crypto_params = {
        crypto: {
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
      }
      post '/cryptos', params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['name']).to include 'can\'t be blank'
    end
    it 'does not create crypto without age' do
      crypto_params = {
        crypto: {
          name: 'Etherium',
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
      }
      post '/cryptos', params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['age']).to include 'can\'t be blank'
    end
    it 'does not create crypto without name' do
      crypto_params = {
        crypto: {
          name: 'Doge',
          age: 14,
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
      }
      post '/cryptos', params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['creator']).to include 'can\'t be blank'
    end
    it 'does not create crypto without name' do
      crypto_params = {
        crypto: {
          age: 14,
          creator: "Satoshi Nakamotoo"
        }
      }
      post '/cryptos', params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['image']).to include 'can\'t be blank'
    end
  end
  describe "update validation" do
    it "updates a crypto" do
      old_crypto = Crypto.create(
          name: "Angular",
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      )
      crypto_params = {
        crypto: {
          name: '',
          age: 14,
          creator: "TSatoshi Nakamotooo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
      }
      patch "/cryptos/#{old_crypto.id}", params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['name']).to include 'can\'t be blank'
    end 

    # create method
    it "updates a crypto" do
      old_crypto = Crypto.create(
          name: "Angular",
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      )
      crypto_params = {
        crypto: {
          name: 'Sngular',
          age: '',
          creator: "TSatoshi Nakamotooo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
      }
      patch "/cryptos/#{old_crypto.id}", params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['age']).to include 'can\'t be blank'
    end 
    it "updates a crypto" do
      old_crypto = Crypto.create(
          name: "Angular",
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      )
      crypto_params = {
        crypto: {
          name: 'Angular',
          age: 14,
          creator: "",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
        }
      }
      patch "/cryptos/#{old_crypto.id}", params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['creator']).to include 'can\'t be blank'
    end 

    # update method
    it "updates a crypto" do
      old_crypto = Crypto.create(
          name: "Angular",
          age: 14,
          creator: "Satoshi Nakamotoo",
          image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"
      )
      crypto_params = {
        crypto: {
          name: '',
          age: 14,
          creator: "TSatoshi Nakamotooo",
          image: ""
        }
      }
      patch "/cryptos/#{old_crypto.id}", params: crypto_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['image']).to include 'can\'t be blank'
    end 
  end 
end
