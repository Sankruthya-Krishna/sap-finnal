using { com.practice.studentdb as db } from'../db/schema';
service StudentDB{
    entity Student as projection on db.Student;
    entity Gender as projection on db.Gender;
    entity User as projection on db.User;
    entity Options as projection on db.Options
    {
         @UI.Hidden : true
        ID,
        * 
    };
}
annotate StudentDB.Student with @odata.draft.enabled;
annotate StudentDB.Gender with @odata.draft.enabled;
annotate StudentDB.User with @odata.draft.enabled;
annotate StudentDB.Options with @odata.draft.enabled;
annotate StudentDB.Student with{
   first_name      @assert.format: '^[a-zA-Z]{2,}$';
    last_name      @assert.format: '^[a-zA-Z]{2,}$';    
    email     @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
     pan     @assert.format: '^[A-Z]{5}[0-9]{4}[A-Z]{1}$';

}  
annotate StudentDB.User.Options with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: opt_ID
    },
],
    UI.FieldGroup #OptionUser:{
        $Type:'UI.FieldGroupType',
        Data:[
              {
            Value:opt_ID
        },
        ],
    },
    UI.Facets:[
            {
        $Type :'UI.ReferenceFacet',
        ID : 'OptionUserFacet',
        Label : 'OptionUser',
        Target : '@UI.FieldGroup#OptionUser',
    },
    ],

);
annotate StudentDB.Options with @(UI.LineItem: [
     {
            Value:code,
        },
        {
            Value:des,
        }
],
UI.FieldGroup #Option: {
        $Type: 'UI.FieldGroupType',
        Data : [
        {
            Value:code,
        },
        {
            Value:des,
        }

        ],
    },
    UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'OptionsFacet',
            Label:'Options facets',
            Target:'@UI.FieldGroup#Option'
        },
  ],
);


annotate StudentDB.User with @(
    UI.LineItem        : [
        {Value: userId},
        {Value: name},
        {Value: email},
        {Value: Options.opt.code},
    ],
    UI.FieldGroup #User: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: userId},
            {Value: name},
            {Value: email},
        ],

    },
    UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'UserFacet',
            Label:'user facets',
            Target:'@UI.FieldGroup#User'
        },
        {
            $Type:'UI.ReferenceFacet',
            ID:'OptionsFacet',
            Label:'option user facets',
            Target:'Options/@UI.LineItem'
        },
    ],
);
annotate StudentDB.Gender with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    },
],
    UI.SelectionFields:[code,description],
);
annotate StudentDB.Student with @(
    UI.LineItem:[
        {
            Value:studentid
        },
        {
            Value:first_name
        },
        {
            Value:last_name
        },
        {
            Value:email
        },
         {
            Value:pan
        },
        {
            $Type: 'UI.DataField',
            Label:'Gender',
            Value: gender.description
        },
        

    ],
    UI.SelectionFields: [first_name, last_name], 

    UI.FieldGroup #StudentInformation:{
         $Type : 'UI.FieldGroupType',

        Data:[
            {
                $Type:'UI.DataField',
            Value:studentid,
            },
            {
                $Type:'UI.DataField',
            Value:first_name,
            },
            {
                $Type:'UI.DataField',
            Value:last_name,
            },
            {
                $Type:'UI.DataField',
            Value:email,
            },
            {
                $Type:'UI.DataField',
            Value:pan,
            },
            {
                $Type: 'UI.DataField',
                Label:'Gender',
                Value: gender_code,
            },
        ],
            },
       UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#StudentInformation',
        },
    ],
    
       
);
annotate StudentDB.Student with {
    gender @(
       // Common.Text:gender.description,
    Common.ValueListWithFixedValues: true,
    Common.ValueList: {
        Label: 'Genders',
        CollectionPath: 'Gender',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: 'gender_code',
                ValueListProperty: 'code'
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'description'
            }
        ]
    }
)}
annotate StudentDB.User.Options with {
    opt @(
        Common.Text: opt.des,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Options',
            CollectionPath : 'Options',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : opt_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'des'
                },
            ]
        }
    );
}