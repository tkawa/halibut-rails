# Halibut::Rails

Rails Template Handler for [Halibut](https://github.com/locks/halibut) Builder.

Useful to make [HAL](http://stateless.co/hal_specification.html) JSON responses in Rails such as Web APIs.


## Installation

Add this line to your application's Gemfile:

    gem 'halibut-rails'

And then execute:

    $ bundle

## Usage

You can write Halibut Builder syntax in view template.

Template file is recognized by extension `.halibut`.

*Notice:* You don't need `Halibut::Builder.new`. Instead, use `link 'self'` for indicating self path.

```ruby
# app/views/orders/index.json.halibut
property 'currentlyProcessing', 14
property 'shippedToday', 20
property 'total', @orders.size

namespace 'th', 'http://things-db.com/{rel}'

link 'self', orders_path(page: @orders.current_page)
link 'find', '/orders{?q}', templated: true
link 'next', orders_path(page: @orders.next_page) unless @orders.last_page?
link 'prev', orders_path(page: @orders.prev_page) unless @orders.first_page?

@orders.each do |order|
  resource 'orders', order_path(order) do
    property 'total', order.total
    property 'currency', order.currency
    property 'status', order.status
    link 'th:customer', customer_path(order.customer)
  end
end
```

This will build the following structure:

```json
{
  "currentlyProcessing": 14,
  "shippedToday": 20,
  "total": 35,
  "_links": {
    "self": { "href": "/orders" },
    "find": { "href": "/orders{?q}", "templated": true },
    "next": { "href": "/orders?page=2" },
    "curie": {
      "href": "http://things-db.com/{rel}",
      "templated": true,
      "name": "th"
    }
  },
  "_embedded": {
    "orders": [
      {
        "total": 30.00,
        "currency": "USD",
        "status": "shipped",
        "_links": {
          "self": { "href": "/orders/123" },
          "th:customer": { "href": "/customers/7809" }
        },
      },
      {
        "total": 20.00,
        "currency": "USD",
        "status": "processing",
        "_links": {
          "self": { "href": "/orders/124" },
          "th:customer": { "href": "/customers/12369" }
        }
      }
    ]
  }
}
```

As the example above, you can use instance variables and helpers ordinarily.

## Restriction

`relation` notation is not supported yet.


## Contributing

1. Fork it ( http://github.com/<my-github-username>/halibut-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
