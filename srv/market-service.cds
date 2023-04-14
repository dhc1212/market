using {com.market as db} from '../db/data-model';

service Market {
	@readonly entity Pictures as projection on db.Pictures;  
	@readonly entity Image as projection on db.Image;   

    entity Customer as projection on db.Customer        { * } ;  
    entity Products as projection on db.Products        { * } ;
    entity Orders as projection on db.Orders            { * } ;
    entity Address as projection on db.Address            { * } ;
    

    function fnTestCal( custID : String) returns String;
}  
