require 'rails_helper'

RSpec.feature "ProductIndex", type: :feature do
  before do
    create_list(:product, 2)
    create(:product, status: 'published')
  end

  context 'without logged in user' do
    let(:prod) { create(:product, name: 'asdasd') }
    before { visit products_path }

    it 'shows only published products' do
      id = Product.published.first.id
      expect(page.find("##{id}")).to have_content(Product.published.first.name)
    end

    it 'doesn`t show unpublished products' do
      expect(page).to_not have_content(prod.name)
    end

    it 'shows no links' do
      expect(page).to_not have_content('Published')
      expect(page).to_not have_content('Archive')
      expect(page).to_not have_content('Draft')
      expect(page).to_not have_content('Edit')
      expect(page).to_not have_content('Delete')
    end
  end

  context 'with logged in user' do
    before do
      @user = create(:user)
      create_list(:product, 3, user_id: @user.id)
      sign_in(@user)
      visit products_path
    end

    it 'shows @user products and published products' do
      @user.products.each do |n|
        expect(page).to have_content(n.name)
      end
      expect(page).to have_content(Product.published.first.name)
    end

    it 'does not show unpublished products from another user' do
      expect(page).to_not have_content(Product.draft.first)
    end

    it 'shows links to perform actions over products' do
      id = @user.products.first.id
      expect(page.find("##{id}")).to have_content('Published')
      expect(page.find("##{id}")).to have_content('Draft')
      expect(page.find("##{id}")).to have_content('Archive')
      expect(page.find("##{id}")).to have_content('Edit')
      expect(page.find("##{id}")).to have_content('Delete')
    end

    it 'doesn`t show links to perform actions over another users products' do
      id = Product.published.first.id
      expect(page.find("##{id}")).to_not have_content('Published')
      expect(page.find("##{id}")).to_not have_content('Draft')
      expect(page.find("##{id}")).to_not have_content('Archive')
      expect(page.find("##{id}")).to_not have_content('Edit')
      expect(page.find("##{id}")).to_not have_content('Delete')
    end

    it 'changes product status to published' do
      id = @user.products.first.id
      page.find("##{id}").click_link('Archive')
      expect(@user.products.first.status).to eql('archived')
    end

    it 'deletes product' do
      product = @user.products.first
      size = @user.products.size
      expect {
        page.find("##{product.id}").click_link('Delete')
      }.to change{ @user.products.count }.by(-1)
      expect(page).to_not have_content(product.name)
    end
  end
end
