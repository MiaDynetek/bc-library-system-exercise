table 50705 RentedBooks
{
    DataClassification = ToBeClassified;
    Caption = 'Rented Books';
    
    fields
    {
        field(210;"Rent ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(220;"Book Rented"; Boolean)
        {
            DataClassification = ToBeClassified;
            
        }
        field(230;"Date Rented"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;   
            
        }
        field(240;"Customer Name"; Text[50])
        {
            TableRelation = Customer;
            DataClassification = ToBeClassified;
            NotBlank = true;   
        }
        field(250;"Book ID"; Integer)
        {
            TableRelation = Library."Book ID";
            DataClassification = ToBeClassified;
        }
        field(260;"Book Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // field(90;"Status"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        // }
    }
    
    keys
    {
        key(PK; "Rent ID")
        {
            Clustered = true;
        }
    //     key(FK; "Customer Name", "Book ID")
    //     {
    //        Unique = true; 
    //     }
    }
    
    fieldgroups
    {
        // fieldgroup(DropDown;"Book Status")
        // {
            
        // }
    }
    procedure UpdateRentedBook()
    var
        libraryBooks: Record Library;
    begin
        libraryBooks.SetFilter("Book ID", '=%1', Rec."Book ID");
        libraryBooks.FindFirst();
        libraryBooks.Rented := Rec."Book Rented";
        libraryBooks."Rented Count" := libraryBooks."Rented Count" + 1;
        libraryBooks.Modify();
    end;
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        rentBook2.Run();
    end;
    
    trigger OnModify()
    begin
        //LibraryBook.Rented := Rec."Book Rented";
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    var
        RentedBook1: Record RentedBooks;
        rentBook2: Page RentBook;

}