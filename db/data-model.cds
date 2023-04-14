namespace com.market;

using { Currency, managed, cuid, temporal } from '@sap/cds/common';

type status : String enum {pending; order; delivered; }

entity Pictures {
    key Id              : UUID;
    @Core.MediaType     : mediaType
    content             : LargeBinary;
    @Core.IsMediaType   : true
    mediaType           : String;
    filename            : String;
}

entity Image {
    key imageId         : UUID;
    @Core.MediaType     : 'image/png'
    picture             : LargeBinary;
}

entity Customer : managed {
    key customerID      : String;
    CompanyName         : String(40) not null;
    dateOfBirth         : Date;
    contactName         : String;
    address             : Composition of many Address;
}
// entity Customer : managed {
//     key customerID      : String;
//     CompanyName         : String(40) not null;
//     dateOfBirth         : Date;
//     contactName         : String;
//     address             : Composition of many Address on address.parent = $self;
// }

entity Address : cuid, managed {
    key ID              : UUID;
    supplier            : Association to Supplier;
    street              : String(60);
    city                : String(60);
    postalcode          : String(10);
    phone               : localized String(24);
}
// entity Address : cuid, managed {
//     pareant             : Association to one Customer;
//     supplier            : Association to Supplier;
//     street              : String(60);
//     city                : String(60);
//     postalcode          : String(10);
//     phone               : localized String(24);
// }
entity Products: managed {
    key productID       : Integer;
    productName         : String(40);
    description         : String(100);
    quantityPerUnit     : String(20);
    unitPrice           : Decimal(16, 4);
    unitsInStock        : Integer not null;
    discontinued        : Boolean;
    supplier            : Composition of Supplier { supplierID };
    category            : Composition of Category { categoryID };
    orders              : Composition of many Orders on orders.products = $self;
}

entity Supplier : managed {
    key supplierID      : Integer;
    companyName         : localized String(40) not null;
    contactName         : localized String(30);
    contactTitle        : localized String(30);
    address             : Composition of many Address on address.supplier = $self;
    products            : Composition of many Products on products.supplier = $self;  
}

entity Category : managed {
    key categoryID      : Integer;
    categoryName        : String(45) not null;
    description         : String(60);
    // imageUrl  : String @Core.IsURL @Core.MediaType: imageType;
    @Core.MediaType     :'image/png'
    picture             : LargeBinary;
    products            : Composition of many Products on products.category = $self;
}

entity Employee : managed {
    key employeeID      : Integer;
    LastName            : localized String(20) not null;
    FirstName           : localized String(20) not null;
    dateOfBirth         : Date;
    @Core.MediaType     : 'image/png'
    photo               : LargeBinary;
} 

entity Orders : managed, cuid, temporal {
    OrderNo             : String(10) @title:'Order Number'; 
    discount            : status default '할인 불가';
    orderDate           : Date not null;
    requiredDate        : Date not null;   
    shippedDate         : Date ;
    deliveredDate       : DateTime;
    price               : Integer;
    currency            : Currency;
    order_status        : status default '배송 준비 중';
    ShippingAddress     : Composition of one OrderShippingAddress;
    customer            : Composition of Customer;
    employee            : Composition of Employee;
    items               : Composition of many OrderItems on items.parent = $self;
    products            : Association to Products;
}

entity OrderShippingAddress : cuid, managed {
  parent                : Association to Orders ;
  street                : String(60);
  city                  : String(60);
  postalcode            : String(10);
  phone                 : localized String(24);
};

entity OrderItems : cuid {
    parent              : Association to Orders;
    products            : Composition of Products;
    customer            : Composition of Customer;
    quantity            : Integer;
    shipVia             : String(2) enum {
        ship    = '배'; 
        train   = '기차';
        truck   = '트럭'; 
        air     = '비행기'; 
    };
    netamount           : Integer not null;
    currency            : Currency;
}
