const cds=require('@sap/cds');
module.exports= cds.service.impl(async function(){
    const{Student,Gender}=this.entities();
    this.on('READ', Student, async (req) => {
        const results = await cds.run(req.query);
        if (Array.isArray(results)) {
            results.forEach(element => {
                if(element.gender=='F') element.gender="Female"
                if(element.gender=='M') element.gender="Male"
            });
        }

        return results;
    });
    this.before('CREATE',Student,async(req) => {
        let query1=SELECT.from(Student).where({ref:["email"]},"=",{val:req.data.email});
        result=await cds.run(query1);
         if (result.length>0){
            req.error({'code':'STEMAILEXISTS',message:'student with such eemail id alredy exixts'});
         }
    });
    this.before('UPDATE',Student,async(req) => {
        const {email}=req.data;
        if(email){
            const query=SELECT.from(Student).where({emal:email}).and({ ID: { "!=": req.data.ID }});
        }
        const result=await cds.run(query1);
         if (result.length>0){
            req.error({'code':'STEMAILEXISTS',message:'student with such eemail id alredy exixts'});
         }
    // this.on('READ',Gender,async(req)=>{
    //     genders=[
    //         {"code":"M","description":"Male"},
    //         {"code":"F","description":"Female"}
    //     ]
    //     genders.$count=genders.length
    //     return genders;
    // })
});
});

    