require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:creator) { create(:user) }
  let(:category) { create(:category) }

  before do
    create_list(:product, 2, user_id: creator.id, category_id: category.id)
    create_list(:product, 2, status: 'archived', user_id: creator.id, category_id: category.id)
    create_list(:product, 2, status: 'published', user_id: creator.id, category_id: category.id)
  end

  describe 'GET #index' do
    before do
      @user = create(:user)
      @product = create(:product, user_id: @user.id, status: 'published')
      create(:product, user_id: @user.id)
    end

    context 'when a user is signed in' do
      before do
        sign_in(@user)
        get :index
      end

      it 'returns succssfully' do
        expect(response).to be_successful
      end

      it 'follows the routes successfully' do
        expect(controller.controller_path).to eq('products')
      end

      it 'renders the index template' do
        expect(response).to render_template("index")
      end

      it 'shows published products and current_user products' do
        expect(controller.instance_variable_get(:@products)).to match_array(@user.products.or(Product.published))
      end
    end

    context 'when there is no user signed in' do
      it 'shows only published products' do
        get :index
        expect(controller.instance_variable_get(:@products)).to match_array(Product.published)
      end
    end
  end

  describe 'GET #new' do
    before do
      sign_in(creator)
      get :new
    end

    it 'returns succssfully' do
      expect(response).to be_successful
    end

    it 'assigns a newly created product' do
      expect(controller.instance_variable_get(:@product)).to be_a_new(Product)
    end
  end

  describe 'POST #create' do
    before { sign_in(creator) }

    context 'when product is valid' do
      before do
        post :create, params: { product: FactoryBot.attributes_for(:product, user_id: creator.id, category_id: category.id) }
      end

      it 'creates a product' do
        expect(controller.instance_variable_get(:@product)).to be_a(Product)
      end

      it 'redirects to #new' do
        expect(response).to redirect_to(products_path)
      end

      it 'has status code 302' do
        expect(response).to have_http_status(302)
      end
    end

    context 'when product is invalid' do
      it 'assigns current_user id as default, even if another user is passed' do
        post :create, params: { product: FactoryBot.attributes_for(:product) }
        expect(controller.instance_variable_get(:@product).user_id).to be(creator.id)
      end

      it 'does not accept an invalid user(name)' do
        post :create, params: { product: FactoryBot.attributes_for(:product, name: nil) }
        expect(response).to render_template(:new)
      end

      it 'does not accept an invalid user(price)' do
        post :create, params: { product: FactoryBot.attributes_for(:product, price: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    context 'when the user is the owner of the product' do
      before do
        sign_in(creator)
        get :show, params: { id: Product.first.id }
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end

      it 'has status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'assigns @product correctly to draft user' do
        expect(controller.instance_variable_get(:@product)).to eql(Product.first)
      end

      it 'renders show template with published product' do
        get :show, params: { id: Product.last.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when the user isn´t signed in and doesn´t own the product' do
      it 'renders show template with published product' do
        get :show, params: { id: Product.last.id }
        expect(response).to render_template(:show)
      end

      it 'redirects to product_path when trying to access unpublished product' do
        get :show, params: { id: Product.first.id }
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is signed in' do
      before { sign_in(creator) }

      context 'when the user is the owner of the product' do
        before { get :edit, params: { id: Product.first.id } }

        it 'returns succssfully' do
          expect(response).to be_successful
        end

        it 'renders edit template' do
          expect(response).to render_template(:edit)
        end

        it 'has http_status 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the user isn´t the owner of the product' do
        before do
          create(:product)
          get :edit, params: { id: Product.last.id }
        end

        it 'redirects to products_path' do
          expect(response).to redirect_to(products_path)
        end
      end
    end

    context 'when user isn´t signed in' do
      before do
        sign_out(creator)
        get :edit, params: { id: Product.first.id }
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'has status code 302' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PUT #update' do
    context 'when user is signed in' do
      before { sign_in(creator) }

      context 'when user owns the product' do
        before do
          put :update, params: { id: Product.first.id, product: { name: 'laptop' } }
        end

        it 'updates name to laptop' do
          expect(controller.instance_variable_get(:@product).name).to eq('laptop')
        end

        it 'redirects to products_path' do
          expect(response).to redirect_to(products_path)
        end

        it 'has status code 302' do
          expect(response).to have_http_status(302)
        end
      end

      context 'when product is not owned by user' do
        before do
          create(:product)
          put :update, params: { id: Product.last.id, product: { name: 'laptop' } }
        end

        it 'doesn´t update the product' do
          expect(controller.instance_variable_get(:@product).name).to_not eq('laptop')
        end

        it 'redirects to products_path' do
          expect(response).to redirect_to products_path
        end

        it 'has status code 302' do
          expect(response).to have_http_status(302)
        end
      end
    end

    context 'when no user is signed in' do
      before do
        put :update, params: { id: Product.last.id, product: { name: 'laptop' } }
      end

      it 'does not assign @product' do
        expect(controller.instance_variable_get(:@product)).to be_nil
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is signed in' do
      before { sign_in(creator) }

      context 'when product is owned by user' do
        before do
          delete :destroy, params: { id: Product.first.id }
        end

        it 'destroys the product' do
          expect(controller.instance_variable_get(:@product)).to_not eq(Product.first)
        end

        it 'redirects to products_path' do
          expect(response).to redirect_to(products_path)
        end

        it 'has status code 302' do
          expect(response).to have_http_status(302)
        end
      end

      context 'when user doesn´t own product' do
        before do
          create(:product)
          delete :destroy, params: { id: Product.last.id }
        end

        it 'does not delete product' do
          expect(controller.instance_variable_get(:@product)).to eql(Product.last)
        end

        it 'redirects to products_path' do
          expect(response).to redirect_to(products_path)
        end

        it 'has status code 302' do
          expect(response).to have_http_status(302)
        end
      end
    end

    context 'when user is not signed in' do
      before do
        delete :destroy, params: { id: Product.first.id }
      end

      it 'does not delete product' do
        expect(controller.instance_variable_get(:@product)).to be_nil
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'has status code 302' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
