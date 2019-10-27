json.array! @buys do |buy|
    json.id        buy.id
    json.item_id   buy.item.id
    json.item_name buy.item.name
    json.user_id   buy.user.id
    json.point     buy.point
end