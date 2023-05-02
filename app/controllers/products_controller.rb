class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    current_page = params[:page] || 1
    @products = Product.where(visible: true).order(created_at: :desc).paginate(page: current_page, per_page: 6)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)

    if @product.persisted?
      redirect_to product_path(@product), notice: 'Producto creado exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if @product.visible?
      render :show
    else
      redirect_to products_path, notice: 'Producto no encontrado'
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), notice: 'Producto actualizado exitosamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Producto eliminado exitosamente'
  end

  def search
    @q = params[:q]
    @products = Product.where('name like ?', "%#{@q}%").where(visible: true)
    # render :index
  end

  private

  def set_product
    @product = Product.friendly.find(params[:id])
    # @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :visible, :image)
  end
end
