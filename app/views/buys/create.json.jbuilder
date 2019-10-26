json.buy do
    json.id        @buy.id
    json.status    true
    json.user_id   @buy.user.id
    json.item_id   @buy.item.id
    json.point     @buy.item.point
end