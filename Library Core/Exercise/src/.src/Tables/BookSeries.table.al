table 50703 BookSeries
{
    DataClassification = ToBeClassified;
    Caption = 'Book Series';
    
    fields
    {
        field(1;"Series ID"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            
        }
        field(2;"Series Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;   
        }
    }
    
    keys
    {
        key(PK; "Series ID")
        {
            Clustered = true;
        }
       
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}