require 'rails_helper'

RSpec.describe "/api/v1/document_types", type: :request do

  let(:document_type) { create(:document_type) }
  let(:valid_attributes) { build(:document_type).attributes }

  let(:invalid_attributes) {
    { description: "" }
  }
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      DocumentType.create! valid_attributes
      get api_v1_document_types_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
    context 'with filters' do
      let(:document_type) { create(:document_type, description: "teste")}

      before { get "/api/v1/document_types?description=#{document_type.description}" }

      it 'returns filtered cost centers' do
        expect(document_type.description).to eq("teste")
      end
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      document_type = DocumentType.create! valid_attributes
      get api_v1_document_type_url(document_type), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
      before { post  api_v1_document_types_url, as: :json, params: { document_type: valid_attributes } }
      context "with valid parameters" do
        it "creates a new document" do
          expect(body_json["description"]).to eq("Dinheiro")
        end
      end

      context "with invalid parameters" do
        it "does not create a new ChartsAccount" do
          expect do
            post api_v1_document_types_url,
                 params: { document_type: invalid_attributes }, as: :json
          end.to change(DocumentType.where(description: :description), :count).by(0)
        end
      end


    context "with invalid parameters" do
      it "does not create a new DocumentType" do
        expect {
          post api_v1_document_types_url,
               params: { document_type: invalid_attributes }, as: :json
        }.to change(DocumentType, :count).by(0)
      end

      it "renders a JSON response with errors for the new document_type" do
        post api_v1_document_types_url,
             params: { document_type: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          description: "Cartão de Crédito"
        }
      }

      it "updates the requested document_type" do
        document_type = DocumentType.create! valid_attributes
        patch api_v1_document_type_url(document_type),
              params: { document_type: new_attributes }, headers: valid_headers, as: :json
        document_type.reload
        expect(document_type.description).to eq("Cartão de Crédito")
      end

      it "renders a JSON response with the document_type" do
        document_type = DocumentType.create! valid_attributes
        patch api_v1_document_type_url(document_type),
              params: { document_type: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the document_type" do
        document_type = DocumentType.create! valid_attributes
        patch api_v1_document_type_url(document_type),
              params: { document_type: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested document_type" do
      document_type = DocumentType.create! valid_attributes
      expect {
        delete api_v1_document_type_url(document_type), headers: valid_headers, as: :json
      }.to change(DocumentType, :count).by(-1)
    end
  end
end
