page 50707 RentBook
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RentedBooks;
    Caption = 'Rent Book';
    DelayedInsert = true;
    
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
               Caption = 'Rent Book';
                field("Book Name"; Rec."Book Name")
                {

                    ToolTip = 'Specifies the value of the Book Name field.';
                    Editable = false;
                }
                field("Book Rented"; Rec."Book Rented")
                {
                    ToolTip = 'Specifies the value of the Book Rented field. If the value is true, the book is rented, if it is false, the book is not rented.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Date Rented"; Rec."Date Rented")
                {
                    ToolTip = 'Specifies the value of the Date Rented field.';
                }
                field("Rent ID"; Rec."Rent ID")
                {
                    ToolTip = 'Specifies the value of the Rent ID field.';
                    Visible = false;
                }
                field("Book ID"; Rec."Book ID")
                {
                    ToolTip = 'Specifies the value of the Rent ID field.';
                    Visible = false;
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        // currentBook: Integer;
        // libraryBooks: Record Library;
    begin
        // libraryBooks.SetFilter("Book ID", '=%1', Rec."Book ID");
        // libraryBooks.FindFirst();
        // libraryBooks.Rented := Rec."Book Rented";
        // libraryBooks."Rented Count" := libraryBooks."Rented Count" + 1;
        // libraryBooks.Modify();
        Rec.UpdateRentedBook()
    end;
    // actions
    // {
    //     area(Processing)
    //     {
    //         // action(ActionName)
    //         // {
    //         //     ApplicationArea = All;
                
    //         //     trigger OnAction()
    //         //     var
    //         //         myInt: Integer;
    //         //     begin
                    
    //         //     end;
    //         // }
            
    //     }
    // }
    // trigger OnNewRecord(BelowxRec: Boolean)
    // var
    //     recRef: RecordRef;
    //     newRentedBook: Page RentBook;
    // begin
    //     recRef.GetTable(xRec);  
    //     // newRentedBook.Run();
    //     "Book Name" := xRec."Book Name";  
    //     "Rent ID" := xRec."Rent ID";
    // end;
    // procedure RentBook(record: Record Library) : Record Library
    // var
    //     rentBook: Page RentBook;
    //     simpleText: Text[50];
    //     newRecord: Record RentedBooks;
    // begin
    //     simpleText := record.Title;
    //     // Rec."Book Name" := record.Title;
    //     newRecord.Init();
    //     newRecord."Book Name" := 'Some text';
    //     newRecord.Insert();
        
    //     Message(simpleText); 
    //     exit(record); 
    // end;
    var
        myInt: Integer;
        BookTitle: Text[100];
        RentedBooks: Record RentedBooks;
}