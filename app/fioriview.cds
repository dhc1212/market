using { com.market as my } from '../db/data-model';
using { Currency } from '@sap/cds/common';

// Products Lists ------------------------------------------------------------------------------
annotate my.Products with @(
    UI : {
        SelectionFields : [
            productID,
            productName,
        ],
        LineItem  : [
            { Value: productID,     Label: '{i18n>productID}'},
            { Value: productName,   Label: '{i18n>productName}'},
            { Value: unitPrice,     Label: '{i18n>unitPrice}'},
            { Value: unitsInStock,  Label: '{i18n>unitsInStock}'},
        ],
        HeaderInfo : {
            $Type           : 'UI.HeaderInfoType',
            TypeName        : 'Product',
            TypeNamePlural  : 'Products',
            Title           : {Value  : productName},
            Description     : {$Type : 'UI.DataField', Value : description}
        },
        HeaderFacets : [{
            $Type           : 'UI.ReferenceFacet',
            Target          : '@UI.FieldGroup#HeaderFacet',
            Label           : '{i18n>productName}'
        }],
        FieldGroup#HeaderFacet : {
            $Type           : 'UI.FieldGroupType',
            Data            : [
                { $Type : 'UI.DataField', Label : '{i18n>productID}', Value : productID },
                { $Type : 'UI.DataField', Label : '{i18n>productName}', Value : productName },
                { $Type : 'UI.DataField', Label : '{i18n>unitPrice}', Value : unitPrice },
                { $Type : 'UI.DataField', Label : '{i18n>unitsInStock}', Value : unitsInStock }
            ]
        },
        Facets : [{
            $Type           : 'UI.ReferenceFacet',
            Target          : '@UI.FieldGroup#ProductDetailFacet',
            Label           : '제품 상세'
        }
        ],
        FieldGroup#ProductDetailFacet : {
            Data : [
                { $Type : 'UI.DataField', Label : '{i18n>productID}', Value : productID },
                { $Type : 'UI.DataField', Label : '{i18n>productName}', Value : productName },
                { $Type : 'UI.DataField', Label : '{i18n>unitPrice}', Value : unitPrice },
                { $Type : 'UI.DataField', Label : '{i18n>unitsInStock}', Value : unitsInStock },
                { $Type : 'UI.DataField', Label : '{i18n>supplier}', Value : supplier.supplierID },
                { $Type : 'UI.DataField', Label : '{i18n>category}', Value : category.categoryID },
            ]
        },

    }
);

// 주문 내역 확인 페이지 -------------------------------------------------------------------------------------------
annotate my.Orders with @(
    UI : {
         HeaderInfo : {
            $Type           : 'UI.HeaderInfoType',
            TypeName        : 'Order',
            TypeNamePlural  : 'Orders',
            Title           : { Value : OrderNo },
            Description     : { Value : order_status}
        },
        LineItem  : [
            { Value: customer.contactName,                  Label: '{i18n>contactName}'},
            { Value: products.productName,                  Label: '{i18n>productName}'},
            { Value: products.supplier.contactName,         Label: '{i18n>contactName2}'},
            { Value: order_status,                          Label: '{i18n>order_status}'},
            { Value: items.shipVia,                         Label: '{i18n>items}'},
            { Value: orderDate,                             Label: '{i18n>orderDate}'},
            { Value: requiredDate,                          Label: '{i18n>requiredDate}'},
            { Value: shippedDate,                           Label: '{i18n>shippedDate}'},
            { Value: price,                                 Label: '{i18n>price}'},
            { Value: currency_code,                         Label: '{i18n>currency_code}'},

        ],
        Facets : [{
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.FieldGroup#OrdersDetailFacet',
            Label   : '주문 상세',
            ![@UI.Importance] : #High
        },{
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.FieldGroup#ProductsDetailFacet',
            Label   : '제품 상세'
        },
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.FieldGroup#CustomerDetailFacet',
            Label   : '고객 상세'
        },],
        FieldGroup#OrdersDetailFacet : {
            Data : [
                { $Type : 'UI.DataField', Label : '{i18n>OrderNo}',             Value : OrderNo },
                { $Type : 'UI.DataField', Label : '{i18n>city}',                Value : ShippingAddress.city},
                { $Type : 'UI.DataField', Label : '{i18n>productID}',           Value : products.productID },
                { $Type : 'UI.DataField', Label : '{i18n>contactName}',         Value : customer.contactName },
                { $Type : 'UI.DataField', Label : '{i18n>order_status}',        Value : order_status },
                { $Type : 'UI.DataField', Label : '{i18n>items}',               Value : items.shipVia },
                { $Type : 'UI.DataField', Label : '{i18n>discount}',            Value : discount },
                { $Type : 'UI.DataField', Label : '{i18n>orderDate}',           Value : orderDate },
                { $Type : 'UI.DataField', Label : '{i18n>requiredDate}',        Value : requiredDate },
                { $Type : 'UI.DataField', Label : '{i18n>shippedDate}',         Value : shippedDate },
                { $Type : 'UI.DataField', Label : '{i18n>price}',               Value : price },
                { $Type : 'UI.DataField', Label : '{i18n>currency_code}',       Value : currency_code },
            ]
        },
        FieldGroup#CustomerDetailFacet : {
            Data : [
                { $Type : 'UI.DataField', Label : '{i18n>customerID}',          Value : customer.customerID },
                { $Type : 'UI.DataField', Label : '{i18n>contactName}',         Value : customer.contactName },
                { $Type : 'UI.DataField', Label : '{i18n>CompanyName}',         Value : customer.CompanyName },
                { $Type : 'UI.DataField', Label : '{i18n>dateOfBirth}',         Value : customer.dateOfBirth },
                { $Type : 'UI.DataField', Label : '{i18n>city}',                Value : customer.address.city },
                { $Type : 'UI.DataField', Label : '{i18n>street}',              Value : customer.address.street },
                { $Type : 'UI.DataField', Label : '{i18n>postalcode}',          Value : customer.address.postalcode },
                { $Type : 'UI.DataField', Label : '{i18n>phone}',               Value : customer.address.phone },

            ]
        },
        FieldGroup#ProductsDetailFacet : {
            Data : [
                { $Type : 'UI.DataField', Label : '{i18n>productID}',          Value : products.productID },
                { $Type : 'UI.DataField', Label : '{i18n>productName}',        Value : products.productName },
                { $Type : 'UI.DataField', Label : '{i18n>category}',           Value : products.category.categoryID },
                { $Type : 'UI.DataField', Label : '{i18n>categoryName}',       Value : products.category.categoryName },
                { $Type : 'UI.DataField', Label : '{i18n>description}',        Value : products.category.description },
                { $Type : 'UI.DataField', Label : '{i18n>quantityPerUnit}',    Value : products.quantityPerUnit },
                { $Type : 'UI.DataField', Label : '{i18n>unitPrice}',          Value : products.unitPrice },
                { $Type : 'UI.DataField', Label : '{i18n>unitsInStock}',       Value : products.unitsInStock },
                { $Type : 'UI.DataField', Label : '{i18n>discontinued}',       Value : products.discontinued },
                { $Type : 'UI.DataField', Label : '{i18n>companyName}',        Value : products.supplier.companyName },
                { $Type : 'UI.DataField', Label : '{i18n>contactName2}',       Value : products.supplier.contactName },
                { $Type : 'UI.DataField', Label : '{i18n>contactTitle}',       Value : products.supplier.contactTitle },


            ]
        }
    }
);