def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each { |item|
    item.each { |item_name, item_info|
      if new_hash[item_name] == nil
        new_hash[item_name] = item_info
        new_hash[item_name][:count] = 1
      else
        new_hash[item_name][:count] += 1
      end
    }
  }
  return new_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each { |coupon|
    if cart[coupon[:item]]
      if cart[coupon[:item]][:count] >= coupon[:num]
        cart[coupon[:item]][:count] -= coupon[:num]
        if cart["#{coupon[:item]} W/COUPON"] == nil
          cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
        else
          cart["#{coupon[:item]} W/COUPON"][:count] += 1
        end
      end
    end
  }
  return cart
end

def apply_clearance(cart)
  # code here
  cart.each { |item_name, item_info|
    if item_info[:clearance]
      item_info[:price] = (item_info[:price] * 0.8).round(2)
    end
  }
  return cart
end

def checkout(cart, coupons)
  # code here
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)
  total = 0.0
  cart3.each { |item_name, item_info|
    total += (item_info[:price] * item_info[:count]).round(2)
  }
  if total > 100
    total = (total * 0.9).round(2)
  end
  return total
end
