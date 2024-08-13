# action 4
def user_login():
    username_user = input("Please enter user's username: ")
    password_user = input("Please input user's password: ")

    if username_user not in user_db:
        print("Login failed!!, You dont have an account")
        return False
    
    if user_db[username_user] == password_user:
        print("Login Successful as USER")
        return True
    else:
        print("Login failed!! Password incorrect")
        return False

# action 5 +13 
def admin_login():
    username_admin = input("Please enter admin's username: ")
    password_admin = input("Please input admin's password: ")

    if username_admin not in admin_db:
        print("Login failed!!, You dont have an account")
        return False
    
    if admin_db[username_admin] == password_admin:
        print("Login Successful as ADMIN")
        return True
    else:
        print("Login failed!! Password incorrect")
        return False

# action 6
def generate_session_id():
    return 12345

# action 8
catalog = []

# action 9
def display_catalog():
    print("ID\t\tNAME\t\tCATEGORY\t\tPRICE")
    for product in catalog:
        for value in product.values():
            print(f"{value}", end='\t\t')
        print()

def catalog_add_product():
    product_id = int(input("Enter product ID: "))
    product_name = input("Enter product name: ")
    product_category = input("Enter product category: ")
    product_price = float(input("Enter product price: "))
    product = {'product_id':product_id, 'product_name':product_name, 'product_category':product_category, 'product_price':product_price}
    catalog.append(product)

def catalog_update_product():
    check_product_id = int(input("Enter ID of product to be updated: "))
    prod_new_name = input("Enter new name: ")
    prod_new_category = input("Enter new category: ")
    prod_new_price = float(input("Enter new price: "))
    for item in catalog:
        if item['product_id'] == check_product_id:
            item['product_name'] = prod_new_name
            item['product_category'] = prod_new_category
            item['product_price'] = prod_new_price
            break

def catalog_view_product():
    display_catalog()

# action 12
def checkout():
    print("Select payment option:\n [1]NetBanking\n [2]PayPal")
    checkout_choice = int(input("plesae enter your choice: "))
    if checkout_choice == 1:
        print( "You will be shortly redirected to the portal to make a payment of $20.\n")
    elif checkout_choice == 2:
        print( "You will be shortly redirected to the portal to make a payment of $20.\n")
    else:
        print("You have entered an incorrect choice for payment!!")

# action 10
cart = []

def display_cart():
    print("SESSION ID\t\tPRODUCT ID\t\tQUANTITY")
    for item in cart:
        for value in item.values():
            print(f"{value}", end='\t\t')
        print()

def add_to_cart(sessionid, productid, quantity):
    new_item = {'sessionid':sessionid, 'productid':productid, 'quantity':quantity}
    cart.append(new_item)
    print("A new item has been added\n")

def delete_from_cart(sessionid, productid):
    for item in cart:
        if item['sessionid']==sessionid and item['productid']==productid: 
            cart.remove(item)
            print("An item has ben successfully removed form your cart!")
            print()

def admin_func(admin_session_id):
    print("Options:\n [1]Add product to catalog\n [2]Update existing product info\n [3]View catalog\n [4]Exit loop")
    while True:
        admin_action_choice = int(input("\nEnter your choice: "))
        if admin_action_choice == 1:
            catalog_add_product()
        elif admin_action_choice == 2:
            catalog_update_product()
        elif admin_action_choice == 3:
            catalog_view_product()
        elif admin_action_choice == 4:
            print("Logging out admin!!")
            break
        else:
            print("The choice you have entered is incorrect, please try again!")


def user_func(user_session_id):
    print("Options:\n [1]View cart\n [2]Add to cart\n [3]Delete from cart\n [4]Proceed to checkout! ")
    while True:
        user_action_choice = int(input("\nEnter your choice: "))
        if user_action_choice == 1:
            display_cart()
        elif user_action_choice == 2:
            product_id = int(input("Enter product id to add to cart: "))
            quantity = int(input("Enter quantity: "))
            add_to_cart(user_session_id, product_id, quantity)
        elif user_action_choice == 3:
            product_id = int(input("Enter product id to delete from cart: "))
            delete_from_cart(user_session_id, product_id)
        elif user_action_choice == 4:
            # print("Logging out user!!")
            # break
            checkout()
        else:
            print("The choice you have entered is incorrect, please try again!")






# action 1
# main code
print("Welcome to Demo Marketplace")   # action 2

# action 3
user_db = {'user1':'user1pwd', 'user2':'user2pwd'}
admin_db = {'admin1':'admin1pwd', 'admin2':'admin2pwd'}

while True:
    login_type = input("\nDo you want to login as [user] or [admin]? [press q to quit]: ")
    if login_type.lower() == "admin":
        if admin_login():
            admin_session_id = generate_session_id()
            admin_func(admin_session_id)
            print("Admin session has ended!\n\n")
    elif login_type.lower() == "user":
        if user_login():
            user_session_id = generate_session_id()
            display_catalog()
            user_func(user_session_id)
            # checkout()
            print("User session has ended")
    elif login_type.lower() == "q":
        print("Exiting program\n\n")
        break
    else:
        print("Your login access level[admin|user] is incorrect!!")
