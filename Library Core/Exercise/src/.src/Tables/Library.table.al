table 50211 Library
{
    Caption = 'Library';
    DataClassification = ToBeClassified;
    Extensible = true;
    fields
    {
        field(10; "Book ID"; Integer)
        {
            AutoIncrement = true;
            Caption = '';
        }
        field(20; "Title"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(30; "Author"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(40; "Rented"; Boolean)
        {
            Caption = '';
            ObsoleteState = Removed;
        }
         field(120; "Series"; Integer)
        {
            TableRelation = BookSeries."Series ID";
            Caption = '';
            NotBlank = true;   
        }
        field(50; "Genre"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(60; "Publisher"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(70; "Book Price"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(80; "Publication Date"; Date)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(90; "Pages"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(150; "Prequel"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(160; "Sequel"; Text[50])
        {
            Caption = '';
            NotBlank = true;   
        }
        field(100; "Prequel ID"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(110; "Sequel ID"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
       
        field(140; "Rented Count"; Integer)
        {
            Caption = '';
            NotBlank = true;   
        }
       
        field(170; "Edit Sequel"; Boolean)
        {
            Caption = '';
            NotBlank = true;   
        }

        field(180; "Status"; Enum Statuses)
        {
            Caption = '';
            NotBlank = true;   
        }
        field(190; "Grade"; Enum Grades)
        {
            DataClassification = ToBeClassified;
        }
         field(200; "Grade Justification"; Text[1000])
        {
            Caption = '';
            NotBlank = true;  
        }
        field(210; "Rent ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(220; "Display Message"; Boolean)
        {
            Caption = '';
        }
    }
    keys
    {
        key(PK; "Book ID")
        {
            Clustered = true;
        }
        // key(FK; "Series")
        // {
        //    Unique = true; 
        // }
    }
    procedure AddBookSequel()
    var
        newRecord: Record Library;
        newRentedBook: Page AddBookSequel;
    begin
        newRecord.Init();
        newRecord.Author := Rec.Author;
        newRecord.Series := Rec.Series;
        newRecord.Genre := Rec.Genre;
        newRecord.Publisher := Rec.Publisher;
        newRecord.Publisher := Rec.Publisher;
        newRecord.Prequel := Rec.Title;
        newRecord."Prequel ID" := Rec."Book ID";
        newRecord."Edit Sequel" := true;
        newRecord.Status := enum::Statuses::"Pending Grading";
        newRecord."Display Message" := true;
        newRecord.Insert();
     
        newRentedBook.SetRecord(newRecord);
        newRentedBook.Run();
    end;

    procedure OpenLibraryPage()
    var
        Library: Page LibraryBookList;
    begin
        Library.Editable(false);
        Library.Run();
    end;

    procedure UpdatePrequelSequel()
    var
        libraryBooks: Record Library;
    begin
       if(Rec."Edit Sequel" = true) then
        begin
        libraryBooks.SetFilter("Book ID", '=%1', Rec."Prequel ID");
        libraryBooks.FindFirst();
        libraryBooks.Sequel := Rec.Title;
        libraryBooks."Sequel ID" := Rec."Book ID";
        libraryBooks.Modify();
        end;
    end;
    procedure LastTwoYearsFilter()
    var
        Today: Date;
        TwoYearsAgo: Date;
        NewField: Text[50];
        Library: Record Library;
    begin
        Today := WorkDate();
        TwoYearsAgo := Today - 730;
        Rec.SetFilter("Publication Date", '>%1',TwoYearsAgo);
    end;
    
    procedure RentBook()
    var
        bookData: Record Library;
        simpleText: Text[50];
        newRecord: Record BookTransactions;
        newRentedBook: Page RentBook;
        previousRecord: Record BookTransactions;
    begin
        // bookData.SetRange("Book ID", Rec."Book ID");
        // bookData.FindFirst();
        
        if (Rec.Status <> enum::Statuses::Available) then begin
            Message('This book may not currently be rented, please change the book status to Available before attempting to rent again.');
        end;
        // previousRecord.SetRange("Book ID", Rec."Book ID");
        // previousRecord.SetCurrentKey("Date Rented");
        // previousRecord.Ascending();
        // previousRecord.FindLast();
        if (Rec.Status = enum::Statuses::Available) then begin
        simpleText := Rec.Title;
        newRecord.Init();
        newRecord."Book Name" := simpleText;
        newRecord."Book ID" := Rec."Book ID";
        newRecord."Date Rented" := System.Today();
        newRecord."Days Rented" := 1;
        newRecord."Return Date" := Today() + 1;
        //Rec.Validate(Status, Statuses::Rented);
        newRecord.Validate(Status, Status::Rented);
        //newRecord."Status" := Rec.Status;
        newRecord.Grade := Rec.Grade;
        newRecord."Grade Justification" := Rec."Grade Justification";
        newRecord.Insert();
        // bookData."Rent ID" := newRecord."Rent ID";
        // bookData.Modify();
        newRentedBook.SetRecord(newRecord);
        newRentedBook.Run();
        end;
        
    end;
    procedure ReturnBook()
    var
        previousRecord: Record BookTransactions;
        simpleText: Text[50];
        newRecord: Record BookTransactions;
        newRentedBook: Page RentBook;
        book: Record Library;
        currentRec: Record Library;
    begin
        // book.SetRange("Book ID", Rec."Book ID");
        // book.FindFirst();
        // currentRec.SetRange("Book ID", Rec."Book ID");
        // currentRec.FindFirst();
         if (Rec.Status <> enum::Statuses::Rented) then begin
             if  (Rec.Status <> enum::Statuses::Overdue) then begin
            Message('Before attempting to change the status of this book to available, please ensure it is currently marked as rented or overdue.');
             end;
        end;
        previousRecord.SetRange("Book ID", Rec."Book ID");
        previousRecord.SetCurrentKey("Date Rented");
        previousRecord.Ascending();
        previousRecord.FindLast();
        if (Rec.Status = enum::Statuses::Rented) or (Rec.Status = enum::Statuses::Overdue) then begin
        simpleText := Rec.Title;
        newRecord.Init();
        newRecord."Book Name" := simpleText;
        newRecord."Book ID" := Rec."Book ID";
        newRecord."Date Rented" := System.Today();
        newRecord."Days Rented" := 1;
        newRecord."Return Date" := Today() + 1;
        //newRecord.Validate(Status, Status::Available);
        newRecord.Status := enum::Statuses::"Pending Grading";
        newRecord."Display Message" := true;
        //newRecord."Status" := Rec.Status;
        newRecord."Customer Name" := previousRecord."Customer Name";
        newRecord.Grade := Rec.Grade;
        newRecord."Grade Justification" := Rec."Grade Justification";
        newRecord.Insert();
        // book."Rent ID" := newRecord."Rent ID";
        // book.Modify();
        newRentedBook.SetRecord(newRecord);
        newRentedBook.Run();
        
        end;
       
    end;
    //
    procedure FilterReceivingRepair()

    begin
        Rec.SetRange(Status, enum::Statuses::"Out for repair");
    end;
    procedure ArchiveBook()
    var

    begin
        Rec.Status := enum::Statuses::Archived;
        Rec.Modify();
        Message('The book you selected have been set to Archived.');
        Rec.AddLogs(enum::Statuses::Archived);
    end;


    procedure AddLogs(CurrStatus : enum Statuses)
    var
        newLog: Record BookTransactions;
    begin
        newLog.Init();
        newLog."Book Name" := Rec.Title;
        newLog."Book ID" := Rec."Book ID";
        newLog.Validate(Status, CurrStatus);
        newLog.Grade := Rec.Grade;
        newLog."Grade Justification" := Rec."Grade Justification";
        newLog.Insert();
    end;
 
}
