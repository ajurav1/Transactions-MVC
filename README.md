# Transactions-MVC
A demo project to display transaction list and the balance amount

## Structure Details

- Based on MVC pattern (Model View Controller)

## Layer Categorisation

### Model layer

Model layer handles the maintainance (create, modify, delete) of the data models.

a. Concrete classes of Servicable Protocol
b. Concrete classes of DataModelable Protocol


### View layer

View layer handles the maintainance of the view components.

a. Concrete classes of UIView classes
b. Concrete classes of ViewModelable Protocol
c. It handles all IBAction, IBOutlets and the UI component deleagation


### Controller layer

Controller layer handles the maintainance of the service manager.

a. Sub classes of UIView classes
b. Concrete classes of ViewModelable Protocol
c. It handles all IBAction, IBOutlets and the UI component deleagation

