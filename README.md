# Transactions-MVC
A demo project to display transaction list and the balance amount

## Structure Details

- Based on MVC pattern (Model View Controller)

## Layer Categorisation

### Model layer

Model layer handles the maintainance (create, modify, delete) of the data models.

- Concrete classes of Servicable Protocol
- Concrete classes of DataModelable Protocol


### View layer

View layer handles the maintainance of the view components.

- Concrete classes of UIView classes
- Concrete classes of ViewModelable Protocol
- It handles all IBAction, IBOutlets and the UI component deleagation


### Controller layer

Controller layer holds the objrcts of service manager (Model layer) class and view classes.

- It communicates with these objects with -

- Direct method call to the respective object public methods.
- Delegation Pattern / Closures as a callback. (RXSwift can be used, It will be used in MVVM pattern).

- It maps the data models received from model layer to view model for view layer and vice versa.


## Advantages -

- Highly loosly coupled.
- Model and view layer are highly reusable.
- Independent team can work parallely on model and view layer without any dependency.
- Highly maintainable.



