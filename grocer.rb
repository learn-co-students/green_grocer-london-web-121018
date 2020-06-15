
require 'pry'
def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |object|
     count = cart.count(object)
     object.each do |key,value|
      cart_hash[key] = value
      cart_hash[key][:count] = count
       
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
 
  new_cart = cart.dup 
  cart.each do |item,item_details|
    i = 0 
    coupons.each do |coupon|
      if item == coupon[:item] && item_details[:count] >= coupon[:num] 
        
        new_count = item_details[:count] - coupon[:num]
        new_cart[item][:count] = new_count
        new_cart["#{item} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => item_details[:clearance], 
          :count => i+=1
        }
        
      end 
    end
  end 
  new_cart
end




def apply_clearance(cart)
  # code here
  cart.each do |item, item_details|
    item_details[:clearance] ? item_details[:price] = (item_details[:price]*0.8).round(2) : nil 
  end
  cart 
end

def checkout(cart, coupons) 
  # code here
  total = 0
  cart_hash = consolidate_cart(cart)
  
  new_cart = apply_coupons(cart_hash, coupons) 
  
  cleared_cart = apply_clearance(new_cart)
  cleared_cart.each do |key,value|
    total += value[:price]*value[:count]
  end
   
  total > 100 ? total = total*0.9 : nil 
  total
end

