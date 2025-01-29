# Sales Tax Calculator

## Overview
This application calculates the sales tax for various items based on predefined tax categories. It generates a receipt that includes the total price of items, sales tax, and other relevant information.

## Features
- Calculates basic sales tax (10%) and import duty (5%).
- Supports exempt items (e.g., books, food).
- Generates a detailed receipt with itemized costs and taxes.
- Allows users to define new tax categories interactively.
- Maintains a file cache with tax categories (every user decision is saved in the file).

## Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/lkalwa/receipt-master.git

2. Navigate to the project directory:
    ```bash
    cd receipt-master
   
3. Make sure you have Ruby installed (project was developed using Ruby 3.4.1):
    ```bash
    ruby -v
   
4. Run the application:
    ```bash
    ruby receipt_master.rb
   
## Usage
Follow the prompts to enter item details in the format: `quantity, name, price, imported, exempt`. 

For example:
```
   imported box of chocolates at 10.00
```

Every line has to be typed separately because in case of unknown category program will ask you whether that good is taxable or not.
```bash
Enter your items (format: quantity (imported) name at price), type 'done' when finished:
1 bottle of champagne at 125.99

Unrecognized category for 'bottle of champagne'. Please specify if it is taxable: (yes/no; default yes)
yes
```

If you want to finish entering items, type:
```bash
done
```
## Testing
To run the tests, execute the following command:
```bash
rspec spec
```

## Categories Store

Program uses a file to store categories. If you want to add a new category, you can do it interactively. 
like shown in the Usage section.
You can also edit the file on your own, file is stored in `/data` directory
Every time user provide an information about category of unknown product, it is saved in the file.

## Known Issues

A lot of edge cases are not covered in this code. \
For example, the program does not handle invalid input well.\
It is assumed that the user will provide the correct input format.
No handling of missing tax_categories file.
More tests are needed to cover all edge cases. \
Modelling could be a bit better, but no chance to exercise that within given timeframe.