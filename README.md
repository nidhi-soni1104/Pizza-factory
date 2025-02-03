# PizzaFactory API

PizzaFactory is a Rails 8 API-only backend for a pizza ordering service. This service handles pizza orders, inventory management, and vendor operations such as updating the menu.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [API Endpoints](#api-endpoints)
  - [1. Get Menu](#1-get-menu)
  - [2. Create an Order](#2-create-an-order)
  - [3. Cancel an Order](#3-cancel-an-order)
  - [4. Restock Inventory](#4-restock-inventory)
  - [5. Vendor Endpoints](#5-vendor-endpoints)
    - [a. Create a New Pizza Menu](#a-create-a-new-pizza-menu)
    - [b. Update an Existing Pizza Menu](#b-update-an-existing-pizza-menu)
    - [c. Create a New Topping](#c-create-a-new-topping)
    - [d. Update an Existing Topping](#d-update-an-existing-topping)
    - [e. Create a New Side](#e-create-a-new-side)
    - [f. Update an Existing Side](#f-update-an-existing-side)
- [Testing with Postman](#testing-with-postman)
- [Troubleshooting](#troubleshooting)

## Features

- **Menu Display:** Retrieve pizzas, toppings, sides, and available crust types.
- **Order Processing:** Create orders with customizable pizzas and sides. The system validates business rules (e.g., topping restrictions and free toppings on large pizzas) and verifies/deducts inventory.
- **Order Cancellation:** Cancel orders via a dedicated endpoint.
- **Inventory Management:** Restock inventory items.
- **Vendor Operations:** Vendors can add or update pizzas, toppings, and sides.

## Getting Started

1. **Clone the repository** and navigate into the project directory.
2. **Install dependencies:**  
   ```bash
   bundle install


3. Set up the database:


	rails db:create
	rails db:migrate
	rails db:seed


4. tart the rails server

	rails server

5. he API will be available at http://localhost:3000.

	API Endpoints

	1. Get Menu

		Method: GET
		URL: http://localhost:3000/menu
		Description: Returns all pizzas, toppings, sides, and the fixed list of crust types.
		Payload: None


	2. Create an Order
		Method: POST

		URL: http://localhost:3000/orders

		Headers: Content-Type: application/json

		Description: Creates a new order with one or more pizzas and optional side orders. Business rules are validated and inventory is checked.

		Sample Payload:

		json
		{
		  "order": {
		    "pizza_orders_attributes": [
		      {
		        "pizza_menu_id": 1,
		        "size": "medium",
		        "crust": "New hand tossed",
		        "pizza_toppings_attributes": [
		          { "topping_id": 1 }
		        ]
		      }
		    ],
		    "order_sides_attributes": [
		      { "side_id": 1 }
		    ]
		  }
		}

	3. Cancel an Order
		Method: PATCH

		URL: http://localhost:3000/orders/:id/cancel
		Replace :id with the actual order ID (e.g., 1).

		Headers: Content-Type: application/json

		Description: Cancels an order if it hasn’t already been cancelled.

		Payload: None

		Example URL:

		http://localhost:3000/orders/1/cancel


	4. Restock Inventory
		Method: POST

		URL: http://localhost:3000/inventory/restock

		Headers: Content-Type: application/json

		Description: Restocks an inventory item (topping, side, or pizza).

		Sample Payload:

		json
		{
		  "inventory": {
		    "item_type": "topping",
		    "item_name": "Black olive",
		    "quantity": 10
		  }
		}


	5. Vendor Endpoints
	Vendor endpoints allow vendors to add or update menu items.

	a. Create a New Pizza Menu
		Method: POST

		URL: http://localhost:3000/vendor/pizza_menus

		Headers: Content-Type: application/json

		Description: Creates a new pizza menu item.

		Sample Payload:

		json
		{
		  "pizza_menu": {
		    "name": "New Special",
		    "category": "Vegetarian",
		    "price_regular": 180,
		    "price_medium": 250,
		    "price_large": 350
		  }
		}

	b. Update an Existing Pizza Menu
		Method: PATCH

		URL: http://localhost:3000/vendor/pizza_menus/:id
		Replace :id with the pizza menu ID.

		Headers: Content-Type: application/json

		Description: Updates details (e.g., pricing) of an existing pizza.

		Sample Payload:

		json
		{
		  "pizza_menu": {
		    "price_regular": 190,
		    "price_medium": 260,
		    "price_large": 360
		  }
		}

	c. Create a New Topping
		Method: POST

		URL: http://localhost:3000/vendor/toppings

		Headers: Content-Type: application/json

		Description: Creates a new topping.

		Sample Payload:

		json
		{
		  "topping": {
		    "name": "Olives",
		    "topping_type": "veg",
		    "price": 15
		  }
		}

	d. Update an Existing Topping
		Method: PATCH

		URL: http://localhost:3000/vendor/toppings/:id
		Replace :id with the topping ID.

		Headers: Content-Type: application/json

		Description: Updates an existing topping.

		Sample Payload:

		json
		{
		  "topping": {
		    "price": 40
		  }
		}

	e. Create a New Side
		Method: POST

		URL: http://localhost:3000/vendor/sides

		Headers: Content-Type: application/json

		Description: Creates a new side item.

		Sample Payload:

		json
		
		{
		  "side": {
		    "name": "Garlic Bread",
		    "price": 50
		  }
		}

	f. Update an Existing Side
		Method: PATCH

		URL: http://localhost:3000/vendor/sides/:id
		Replace :id with the side ID.

		Headers: Content-Type: application/json

		Description: Updates an existing side item.

		Sample Payload:

		json
		{
		  "side": {
		    "price": 55
		  }
		}


Testing with Postman

For each endpoint:

	Set the HTTP Method and URL:

		For example, for creating an order, set the method to POST and the URL to http://localhost:3000/orders.
		Set the Headers:

	Go to the Headers tab and add Content-Type with the value application/json.
	Configure the Request Body:

		Click the Body tab.
		Select the raw option.
		In the dropdown next to "raw", choose JSON.
		Paste the sample JSON payload corresponding to the endpoint you are testing.
		Send the Request:

		Click Send to submit the request.
		Review the response returned by the API in the response panel.


	Troubleshooting

	MIME Type Issues:
		If you receive errors about an invalid MIME type, ensure that the Content-Type header is set to application/json and that your body is formatted as valid JSON.

	Missing Fields:
		If you encounter validation errors (e.g., "Item type can't be blank"), double-check that your payload includes all required keys and values.

	Server Logs:
		If something isn’t working as expected, check your Rails server logs for more detailed error messages.
