def consolidate_cart(cart)
  new_cart = {}
  cart.each do |hash|
    hash.each do |food, food_hash|
    
    if !new_cart.has_key?(food) 
      new_cart[food] = food_hash
      new_cart[food][:count] = 1 
    elsif new_cart.has_key?(food)
      new_cart[food][:count] += 1 
    end 
  end 
end 
new_cart
end

def apply_coupons(cart, coupons)
  new_hash = cart
  coupons.each do |coupon_hash|
    new_coupon_food = coupon_hash[:item]
    if !new_hash[new_coupon_food].nil? && new_hash[new_coupon_food][:count] >= coupon_hash[:num]
      temp_hash = {"#{new_coupon_food} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => new_hash[new_coupon_food][:clearance],
        :count => 1
        }
      }
      
      if new_hash["#{new_coupon_food} W/COUPON"].nil?
        new_hash.merge!(temp_hash)
      else
        new_hash["#{new_coupon_food} W/COUPON"][:count] += 1
      end
      
      new_hash[new_coupon_food][:count] -= coupon_hash[:num]
    end
  end
  cart
end


def apply_clearance(cart)
  # code here
    new_cart = {}
  cart.each do |hash, food_hash|
      new_cart[hash] = {}
      new_cart[hash][:clearance] = food_hash[:clearance]
        new_cart[hash][:count] = food_hash[:count]
      if food_hash[:clearance] == true 
        new_cart[hash][:price] = (food_hash[:price] * 0.8).round(2)
      else
        new_cart[hash][:price] = food_hash[:price]
      end 
      end 
  new_cart
end

def checkout(cart, coupons)
  # code here
  new_cart = consolidate_cart(cart)
  newer_cart = apply_coupons(new_cart, coupons)
   newest_cart = apply_clearance(newer_cart)
   total_cart_price = 0
   newest_cart.each do |food, food_hash|
       total_cart_price += (food_hash[:price] * food_hash[:count])
      end 
    if total_cart_price >= 100 
      total_cart_price = (total_cart_price * 0.9).round(2)
    end 
      total_cart_price
end
