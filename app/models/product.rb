class Product < ActiveRecord::Base
  has_many :order_contents
  has_many :orders, through: :order_contents

  has_many :users, through: :orders

  belongs_to :category

  def times_ordered
    self.orders.where("checkout_date IS NOT NULL").count
  end

  def in_cart
    self.orders.where("checkout_date IS NULL").count
  end

  def self.product_count(timeframe = 1000000)

    Product.where("created_at > ?", timeframe.days.ago).count

  end

  def self.category_items(cat_id)
    Product.where("category_id = ?", cat_id).select("id, name")
  end

  def self.delete_category(cat_id)
    Product.where("category_id = ?", cat_id)
            .update_all(:category_id => nil)
  end
end
