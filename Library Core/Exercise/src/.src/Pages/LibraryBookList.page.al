page 50206 LibraryBookList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Library";
    Caption = 'Library Books';
    CardPageId = BookSpecifications;
    DelayedInsert = true;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                } 
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }  
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.';
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'Specifies the value of the Genre field.';
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ToolTip = 'Specifies the value of the Publication Date field.';
                }
                field(Publisher; Rec.Publisher)
                {
                    ToolTip = 'Specifies the value of the Publisher field.';
                }
                // field(Rented; Rec.Rented)
                // {
                //     ToolTip = 'Specifies the value of the Rented field.';
                // }
                field("Series Name"; Rec."Series")
                {
                    Lookup = true;
                    TableRelation = BookSeries."Series Name";
                    ToolTip = 'Specifies the value of the Series Name field.';
                }
                field("Rented Count"; Rec."Rented Count")
                {
                    ToolTip = 'Specifies the value of the Rented Count field.';
                }
                field("Grade"; Rec.Grade)
                {
                     ToolTip = 'Specifies the value of the Grade field.';
                }
                
            }
        }
     
    } 


    actions
    {
        area(Processing)
        {
            action("Display 3 Most Rented Books")
            {
                Caption = 'Display 3 Most Rented Books';
                ToolTip = 'Select this action to view the three most rented books.';
                ApplicationArea = All;
                Image = Import;

                trigger OnAction()
                var
                   LibarayBookMgmt: Codeunit LibarayBookMgmt;
                begin
                    LibarayBookMgmt.Run();
                end;
            }
            action("Rent Book")
            {
                Caption = 'Rent Book';
                ToolTip = 'Select this action rent out the selected item.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                var
                    // rentBook: Record RentedBooks;
                    // rentBook1: Page RentBook;
                begin
                    Rec.RentBook();
                end;
            }
            action("Display Books Published Within The Last 2 Years")
            {
                Caption = 'Display Books Published Within The Last 2 Years';
                ToolTip = 'Select this action to view the books published within the last two years.';
                ApplicationArea = All;
                Image = Import;

                trigger OnAction()
                var
                    // Today: Date;
                    // TwoYearsAgo: Date;
                    // NewField: Text[50];
                    // Library: Record Library;
                begin
                    Rec.LastTwoYearsFilter();
                    // Today := WorkDate();
                    // TwoYearsAgo := Today - 730;
                    // Rec.SetFilter("Publication Date", '>%1',TwoYearsAgo);
                end;
            }
           
            action("Add Book Sequel")
            {
                Caption = 'Add Book Sequel';
                ToolTip = 'Select this action to add a new book as a sequel to the selected book.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.AddBookSequel(); 
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        books: Record Library;
        Today: Date;
        rentedBooks: Record RentedBooks;
    begin
        if books.FindSet() then
        repeat
            rentedBooks.SetFilter("Book ID", '=%1', books."Book ID");
            rentedBooks.SetCurrentKey("Date Rented");
            rentedBooks.Ascending();
            rentedBooks.FindLast();
            Today := WorkDate();
            if books.FindSet() then
            repeat
            if rentedBooks."Return Date" < Today  then
                begin
                    Message('Overdue');
                    //Rec.Status.Names.Set(3, 'Overdue');
                    //TextVar := Rec.Status.Names.Get(Rec.Status.Ordinals.IndexOf(Rec.Status.AsInteger()));
                end;
            until books.Next() = 0;
        until books.Next() = 0;
    end;
}