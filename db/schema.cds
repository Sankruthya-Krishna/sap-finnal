namespace com.practice.studentdb;
entity Student{
    @title:'Student Id'
    key studentid: String(5) @mandatory;
    @title:'First_Name'
    first_name: String(19) @mandatory;
    @title:'Last_Name'
    last_name: String(19);
    @title:'Email Id'
    email: String(19);
     @title:'PAN'
    pan: String(19) @mandatory;
    @title:'GENDER'
    gender: Association to Gender;
};
@cds.persistence.skip
entity Gender{
    @title:'code'
    key code:String(1);
    @title:'Description'
    description:String(20);
}
using {cuid} from '@sap/cds/common';
@assert.unique:{
    userId:[userId]
}
entity User :cuid {
    @title:'userId'
    userId:String(5);
    @title:'name'
    name: String(30);
    @title:'email'
    email: String(30);
    Options:Composition of many{
          key ID: UUID;
        opt :Association to Options;
    }
}
entity Options : cuid {
        @title:'code'
    code:String(5);
    @title:'des'
    des: String(30);
}